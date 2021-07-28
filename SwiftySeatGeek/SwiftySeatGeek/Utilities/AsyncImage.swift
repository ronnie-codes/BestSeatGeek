//
//  AsyncImage.swift
//  SwiftySeatGeek
//

import SwiftUI
import Kingfisher

struct AsyncImage: View {
    let imageUrl: URL?

    var body: some View {
        KFImage
            .url(imageUrl)
            .cancelOnDisappear(true)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { _, _ in }
            .onSuccess { _ in }
            .onFailure { _ in }
            .resizable()
    }
}
