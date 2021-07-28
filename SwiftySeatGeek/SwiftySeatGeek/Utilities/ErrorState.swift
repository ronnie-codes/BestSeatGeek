//
//  ErrorState.swift
//  SwiftySeatGeek
//

import SwiftUI

struct ErrorState: View {
    let error: Error
    let onRetry: () -> Void
    
    var body: some View {
        GeometryReader { view in
            VStack(alignment: .center, spacing: 5) {
                Text("Something went wrong.")
                    .font(.title)
                Text(error.localizedDescription)
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                Spacer()
                Button("Retry", action: onRetry)
                    .font(.title3)
            }
            .padding()
            .position(x: view.frame(in: .local).midX,
                      y: view.frame(in: .global).midY)
        }
    }
}

struct ErrorState_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrollView {
                let error = NSError(domain: "", code: -1, userInfo: [:])
                ErrorState(error: error, onRetry: {})
            }
        }
    }
}
