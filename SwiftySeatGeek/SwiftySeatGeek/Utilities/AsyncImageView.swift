//
//  AsyncImageView.swift
//  SwiftySeatGeek
//

import SwiftUI
import Kingfisher

struct AsyncImageView: View {
    let url: URL?

    var body: some View {
        KFImage
            .url(url)
            .cancelOnDisappear(true)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in }
            .onSuccess { result in  }
            .onFailure { error in }
            .resizable()
    }
}
