//
//  EventListView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventListView: View {
    @ObservedObject private var viewModel = EventListViewModel()
    @State private var searchTerm = ""
    
    var body: some View {
        GeometryReader { _ in
            SearchNavigationView(text: $searchTerm, search: search, cancel: cancel) {
                List(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(item: event)) {
                        EventListCardView(model: event)
                    }
                }
                .navigationBarTitle("Events")
            }
            .navigationBarColor(backgroundColor: UIColor(named: "NavigationBlue")!,
                                tintColor: .white)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    init() {
        viewModel.loadEvents()
    }
    
    func search() {
        
    }
    
    func cancel() {
        
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
