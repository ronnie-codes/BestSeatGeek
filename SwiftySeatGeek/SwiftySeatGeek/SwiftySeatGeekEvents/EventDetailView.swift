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
                if viewModel.favorite {
                    Image("HeartFilled")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            viewModel.favorite = false
                        }
                } else {
                    Image("HeartHollow")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            viewModel.favorite = true
                        }
                }
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
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventDetailView(viewModel: EventViewModel(event: Event.mocks.first!))
        }
    }
}
