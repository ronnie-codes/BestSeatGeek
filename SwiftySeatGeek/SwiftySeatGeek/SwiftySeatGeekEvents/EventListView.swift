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
                    if let error = viewModel.error {
                        ErrorState(error: error, onRetry: {
                            viewModel.refresh()
                        })
                    } else {
                        let events = Array(Set(viewModel.events)).sorted()
                        ForEach(events, id: \.id) { event in
                            let eventViewModel = EventViewModel(event: event)
                            NavigationLink(destination: EventDetailView(viewModel: eventViewModel)) {
                                EventCardView(viewModel: eventViewModel)
                            }
                            Spacer(minLength: 15)
                        }
                        if viewModel.isEmpty {
                            EmptyState()
                        } else if !viewModel.isFull {
                            ActivityIndicator(onAppear: {
                                viewModel.loadEvents(query: searchTerm)
                            })
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .navigationBarTitle(Constants.Strings.eventListTitle.capitalized)
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
