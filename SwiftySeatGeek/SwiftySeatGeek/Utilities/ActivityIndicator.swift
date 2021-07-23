//
//  ActivityIndicator.swift
//  SwiftySeatGeek
//

import SwiftUI

struct ActivityIndicator: View {
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
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
