//
//  EventListViewModel.swift
//  SwiftySeatGeek
//
//  Reference: https://medium.com/swlh/easy-pagination-in-swiftui-da9e1fe3e25e
//

import Foundation
import Combine

final class EventListViewModel: ObservableObject {
    @Published var events = [Event]()

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
        events = [Event]()
    }

    func loadEvents(query: String = "") {
        subscription = EventService.shared
            .getEvents(query.isEmpty ? nil : query, page, limit, sort: sortBy)
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .failure(let error):
                        #if DEBUG
                            // swiftlint:disable:next no_direct_standard_out_logs
                            print(error)
                        #endif
                    default:
                        break
                    }
                },
                receiveValue: { [weak self] nextPage in
                    guard let self = self else {
                        return
                    }
                    self.page += 1
                    self.events.append(contentsOf: nextPage)
                    // If count of data received is less than page value then it is last page.
                    if nextPage.count < self.limit {
                        self.isFull = true
                    }
                }
            )
    }
}
