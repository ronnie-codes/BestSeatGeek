//
//  FavoriteImage.swift
//  SwiftySeatGeek
//

import SwiftUI

struct FavoriteImage: View {
    @Binding var favorite: Bool

    var body: some View {
        if favorite {
            Image(R.image.heartFilled.name)
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    favorite = false
                }
        } else {
            Image(R.image.heartHollow.name)
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    favorite = true
                }
        }
    }
}
