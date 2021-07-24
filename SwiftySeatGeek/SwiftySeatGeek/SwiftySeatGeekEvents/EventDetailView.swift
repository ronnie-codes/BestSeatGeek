//
//  EventDetailView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventDetailView: View {
    @ObservedObject var vm: EventViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(vm.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                if vm.favorite {
                    Image("HeartFilled")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            vm.favorite = false
                        }
                } else {
                    Image("HeartHollow")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            vm.favorite = true
                        }
                }
            }
            .padding(.top)
            HStack(alignment: .center) {
                Spacer()
                AsyncImageView(url: vm.image)
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                Spacer()
            }
            Text(vm.showtime)
                .font(.title2)
                .fontWeight(.bold)
            Text(vm.location)
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
            EventDetailView(vm: EventViewModel(event: Event.mocks.first!))
        }
    }
}
