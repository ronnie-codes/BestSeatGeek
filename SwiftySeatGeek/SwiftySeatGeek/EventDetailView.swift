//
//  EventDetailView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventDetailView: View {
    let item: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            Image("Placeholder")
                .padding(.bottom)
            Text(item.showtime)
                .font(.title2)
                .fontWeight(.bold)
            Text(item.location)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Spacer()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventDetailView(item: Event.mocks.first!)
        }
    }
}
