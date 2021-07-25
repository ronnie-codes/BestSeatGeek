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
                    ForEach(viewModel.eventsGroomed, id: \.id) {
                        let viewModel = EventViewModel(event: $0)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.white)

                            NavigationLink(destination: EventDetailView(viewModel: viewModel)) {
                                EventCardView(viewModel: viewModel)
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                        }
                        .shadow(color: Color(UIColor.lightGray), radius: 6, x: 2, y: 0)
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
        .navigationBarColor(backgroundColor: UIColor(named: "NavigationBlue")!, tintColor: .white)
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
