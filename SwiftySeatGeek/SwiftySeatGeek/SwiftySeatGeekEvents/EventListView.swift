//
//  EventListView.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventListViewModel()
    @State private var searchTerm = ""

    var body: some View {
        SearchNavigation(text: $searchTerm, search: {}, cancel: cancel, content: {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(Set(viewModel.events)).sorted(), id: \.id) {
                        let viewModel = EventViewModel(event: $0)
                        NavigationLink(destination: EventDetailView(viewModel: viewModel)) {
                            EventCardView(viewModel: viewModel)
                        }
                        Spacer(minLength: 15)
                    }
                    if !viewModel.isFull {
                        ActivityIndicator()
                            .onAppear {
                                viewModel.loadEvents(query: searchTerm)
                            }
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .navigationBarTitle("Events")
        })
        .edgesIgnoringSafeArea(.all)
        .navigationBarColor(backgroundColor: Constants.Colors.navigationBlue, tintColor: .white)
        .onChange(of: searchTerm) { _ in
            viewModel.refresh()
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
