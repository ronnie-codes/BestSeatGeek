//
//  EventListCardView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventCardView: View {
    @ObservedObject var viewModel: EventViewModel

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.white)
            HStack {
                VStack {
                    Spacer(minLength: 12)
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -16) {
                        HStack(alignment: .top) {
                            AsyncImage(imageUrl: viewModel.image)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60, alignment: .center)
                                .cornerRadius(7.0)
                            if viewModel.favorite {
                                FavoriteImage(favorite: $viewModel.favorite)
                                    .frame(width: 20, height: 20)
                                    .offset(x: -77, y: -6)
                            } else {
                                FavoriteImage(favorite: $viewModel.favorite)
                                    .frame(width: 20, height: 20)
                                    .hidden()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(viewModel.title)
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            Text(viewModel.location)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Text(viewModel.showtime)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer(minLength: 12)
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .shadow(color: Color(UIColor.lightGray), radius: 6, x: 2, y: 0)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                if let event = Event.mocks.first {
                    EventCardView(viewModel: EventViewModel(event: event))
                }
            }
        }
        .navigationBarColor(backgroundColor: Constants.Colors.navigationBlue,
                            tintColor: .white)
    }
}
