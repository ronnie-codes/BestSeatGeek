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
                UserDefaults.standard.set(favorite, forKey: event.favoriteKey)
            } else {
                UserDefaults.standard.removeObject(forKey: event.favoriteKey)
            }
        }
    }

    var title: String {
        event.title
    }

    var location: String {
        let separator = ", "
        var components = [event.venue.city]
        if let state = event.venue.state {
            components.append(state)
        }
        return components.joined(separator: separator)
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
        self.favorite = UserDefaults.standard.bool(forKey: event.favoriteKey)
    }
}
