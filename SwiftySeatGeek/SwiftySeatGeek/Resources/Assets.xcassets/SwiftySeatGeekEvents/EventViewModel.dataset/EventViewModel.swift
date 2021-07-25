//
//  EventViewModel.swift
//  SwiftySeatGeek
//

import Foundation
import Combine

final class EventViewModel: ObservableObject {
    private let event: Event

    var favorite: Bool {
        willSet {
            objectWillChange.send()
        }
        didSet {
            if favorite {
                UserDefaults.standard.set(favorite, forKey: "/events/\(event.id)/favorite")
            } else {
                UserDefaults.standard.removeObject(forKey: "/events/\(event.id)/favorite")
            }
        }
    }

    var title: String {
        event.title
    }

    var location: String {
        "\(event.venue.city), \(event.venue.state)"
    }

    var showtime: String {
        let separator = ","
        var components = event.showtime.formattedString.components(separatedBy: separator)
        let first = components.first?.uppercased() ?? ""
        let second = components.popLast() ?? ""
        return [first, second].joined(separator: separator)
    }

    var image: URL? {
        guard let image = event.performers?.first?.image, let imageUrl = URL(string: image) else {
            return nil
        }
        return imageUrl
    }

    init(event: Event) {
        self.event = event
        self.favorite = UserDefaults.standard.bool(forKey: "/events/\(event.id)/favorite")
    }
}
