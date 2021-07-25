//
//  Event.swift
//  SwiftySeatGeek
//

import Foundation

protocol Model: Identifiable, Hashable, Decodable {
    var id: Int { get set }
}

struct Venue: Model {
    var id: Int
    let city: String
    let state: String
}

struct Performer: Model {
    var id: Int
    let image: String?
}

struct Event: Model {
    var id: Int
    let title: String
    let showtime: Date

    let venue: Venue
    let performers: [Performer]?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "short_title"
        case showtime = "datetime_local"
        case venue
        case performers
    }

    var favoriteKey: String {
        "/events/\(self.id)/favorite"
    }
}

extension Event: Comparable {
    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.showtime < rhs.showtime
    }
}

extension Event {
    static let mocks =  [
        Event(id: 1,
              title: "Swift Technique",
              showtime: "FRI, 28 Jun 2019 7:30 PM".date ?? Date(),
              venue: Venue(id: 1, city: "Philadelphia", state: "PA"),
              performers: [
                Performer(id: 1, image: "Placeholder")
              ]),

        Event(id: 2,
              title: "Veronica Swift with the Emmet Cohen Trio",
              showtime: "FRI, 28 Jun 2019 7:30 PM".date ?? Date(),
              venue: Venue(id: 2, city: "Buffalo", state: "NY"),
              performers: [
                Performer(id: 1, image: "Placeholder")
              ]),

        Event(id: 3,
              title: "Veronica Swift",
              showtime: "FRI, 09 Aug 2019 7:00 PM".date ?? Date(),
              venue: Venue(id: 3, city: "Aspen", state: "CO"),
              performers: [
                Performer(id: 1, image: "Placeholder")
              ])
    ]
}
