//
//  EventListView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventListView: View {
    @StateObject private var vm = EventListViewModel()
    @State private var searchTerm = ""
    
    var body: some View {
        SearchNavigationView(text: $searchTerm, search: {}, cancel: cancel) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(Set(vm.eventList).sorted(by: { $0.showtime < $1.showtime })), id: \.id) {
                        let vm = EventViewModel(event: $0)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.white)
                            
                            NavigationLink(destination: EventDetailView(vm: vm)) {
                                EventCardView(vm: vm)
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                        }
                        .shadow(color: Color(UIColor.lightGray), radius: 6, x: 2, y: 0)
                        Spacer(minLength: 15)
                    }
                    if !vm.isFull {
                        ProgressView()
                            .onAppear {
                                vm.loadEvents(query: searchTerm)
                            }
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .navigationBarTitle("Events")
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarColor(backgroundColor: UIColor(named: "NavigationBlue")!, tintColor: .white)
        .onChange(of: searchTerm) { _ in
            vm.refresh()
        }
    }
    
    func cancel() {
        searchTerm.removeAll()
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
