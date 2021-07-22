//
//  EventListCardView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventListCardView: View {
    let model: Event
    
    var body: some View {
        HStack {
            Image("Placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(4.0)

            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Text(model.location)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(model.showtime)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .cornerRadius(8)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventListCardView(model: Event.mocks.first!)
        }
    }
}
