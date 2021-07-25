//
//  EventListCardView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventCardView: View {
    @ObservedObject var viewModel: EventViewModel

    var body: some View {
        HStack {
            VStack {
                Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -20) {
                    HStack(alignment: .top) {
                        AsyncImage(imageUrl: viewModel.image)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60, alignment: .center)
                            .cornerRadius(7.0)
                        if viewModel.favorite {
                            Image(R.image.heartFilled.name)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x: -77, y: -6)
                        } else {
                            Image(R.image.heartHollow.name)
                                .resizable()
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
                Spacer()
            }
            .padding(.top, 4)
            .padding(.bottom, 4)
            Spacer()
        }
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                EventCardView(viewModel: EventViewModel(event: Event.mocks.first!))
            }
        }
        .navigationBarColor(backgroundColor: UIColor(named: "NavigationBlue")!,
                            tintColor: .white)
    }
}
