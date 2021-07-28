//
//  EventService.swift
//  SwiftySeatGeek
//

import Foundation
import Combine

final class EventService {
    static let shared = EventService()

    private let clientID = "MjI2MDE0MzJ8MTYyNjgzMjg2NS4yODE1MTE4"
    private let clientSecret = "5c4a56078229a19c630eebcbd48e10726271965a062bdafaecfdfe5a9d513c3d"

    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.seatgeek.com"
        components.path = "/2/events"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "client_secret", value: clientSecret)
        ]
        return components
    }

    private let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.server)
        return decoder
    }()

    struct EventResponse: Decodable {
        let events: [Event]
    }

    func getEvents(_ query: String? = nil, _ page: Int, _ limit: Int, sort: String) -> AnyPublisher<[Event], Error> {
        var components = urlComponents

        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(limit)),
            URLQueryItem(name: "sort", value: sort)
        ])

        if let query = query {
            components.queryItems?.append(URLQueryItem(name: "q", value: query))
        }

        guard let url = components.url else {
            assertionFailure("Invalid url")
            return Just([]).mapError { _ -> Error in }.eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { $0.data }
            .decode(type: EventResponse.self, decoder: decoder)
            .flatMap { Just($0.events) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
