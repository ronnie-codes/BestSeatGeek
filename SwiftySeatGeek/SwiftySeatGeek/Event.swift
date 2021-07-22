//
//  Event.swift
//  SwiftySeatGeek
//

import Foundation

struct Event: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let location: String
    let showtime: String
    
    static let mocks =  [
        Event(title: "Swift Technique", location: "Philadelphia, PA", showtime: "FRI, 28 Jun 2019 7:30 PM"),
        Event(title: "Veronica Swift with the Emmet Cohen Trio", location: "Buffalo, NY", showtime: "FRI, 28 Jun 2019 7:30 PM"),
        Event(title: "Veronica Swift", location: "Aspen, CO", showtime: "FRI, 09 Aug 2019 7:00 PM")
    ]
}
