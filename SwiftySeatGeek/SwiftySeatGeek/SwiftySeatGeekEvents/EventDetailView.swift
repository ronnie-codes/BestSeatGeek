//
//  EventDetailView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventDetailView: View {
    @ObservedObject var viewModel: EventViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                FavoriteImage(favorite: $viewModel.favorite)
            }
            .padding(.top)
            HStack(alignment: .center) {
                Spacer()
                AsyncImage(imageUrl: viewModel.image)
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                Spacer()
            }
            Text(viewModel.showtime)
                .font(.title2)
                .fontWeight(.bold)
            Text(viewModel.location)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.leading)
        .padding(.trailing)
        .navigationTitle(Constants.Strings.eventDetailsTitle.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if let event = Event.mocks.first {
                EventDetailView(viewModel: EventViewModel(event: event))
            }
        }
    }
}
