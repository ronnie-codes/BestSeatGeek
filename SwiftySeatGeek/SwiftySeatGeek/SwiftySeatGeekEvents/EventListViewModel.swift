//
//  EventListViewModel.swift
//  SwiftySeatGeek
//
//  Reference: https://medium.com/swlh/easy-pagination-in-swiftui-da9e1fe3e25e
//

import Foundation
import Combine

final class EventListViewModel: ObservableObject {
    @Published var eventList = [Event]()
    @Published var isLoading = false

    var eventsGroomed: [Event] {
        Array(Set(eventList).sorted(by: { $0.showtime < $1.showtime })) // gotta optimize this
    }

    // Tells if all records have been loaded. (Used to hide/show activity spinner)
    var isFull = false
    // Tracks last page loaded. Used to load next page (current + 1)
    private var page = 1
    // Limit of records per page. (Only if backend supports, it usually does)
    private let limit = 30

    private let sortBy = "\(Event.CodingKeys.showtime.rawValue).asc"

    private var subscription: AnyCancellable?

    func refresh() {
        page = 1
        isFull = false
        eventList.removeAll()
    }

    func loadEvents(query: String = "") {
        subscription = EventService.shared.getEvents(query.isEmpty ? nil : query, page, limit, sort: sortBy)
            .catch { error -> AnyPublisher<[Event], Never> in
                print(error)
                return Just(self.eventList).mapError { _ -> Never in }.eraseToAnyPublisher()
            }
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                self.page += 1
                self.eventList.append(contentsOf: $0)
                // If count of data received is less than page value then it is last page.
                if $0.count < self.limit {
                    self.isFull = true
                }
        }
    }
}
