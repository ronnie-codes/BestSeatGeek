//
//  ActivityIndicator.swift
//  SwiftySeatGeek
//

import SwiftUI

struct ActivityIndicator: View {
    let onAppear: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 15)
            HStack(alignment: .center) {
                Spacer()
                ProgressView()
                Spacer()
            }
            Spacer(minLength: 15)
        }
        .onAppear() {
            onAppear?()
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(onAppear: nil)
    }
}
