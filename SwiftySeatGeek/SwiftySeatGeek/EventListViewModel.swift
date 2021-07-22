//
//  EventListViewModel.swift
//  SwiftySeatGeek
//

import Foundation
import Combine

final class EventListViewModel: ObservableObject {
    @Published var events = [Event]()
    
    func loadEvents() -> Void {
        events = Event.mocks
    }
}
