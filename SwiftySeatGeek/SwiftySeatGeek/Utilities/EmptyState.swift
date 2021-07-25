//
//  EmptyState.swift
//  SwiftySeatGeek
//

import SwiftUI

struct EmptyState: View {
    var body: some View {
        GeometryReader { view in
            Text("Nothing to see here.")
                .font(.title)
                .position(x: view.frame(in: .global).midX, y: view.frame(in: .global).midY)
        }
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState()
    }
}
