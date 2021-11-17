//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 17/11/2021.
//

import SwiftUI
import Combine

class CoinImageService {

    @Published var image: UIImage?
    private var coin: Coin
    private var imageSubscription: AnyCancellable?
    private var fileManager = LocalFileManager.shard
    private let folderName = "Crypto_Tracker"
    private let imageName: String

    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getImage()
    }

    private func getImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            self.image = savedImage
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription =
            NetworkManager.shard.download(fromURL: url)
            .tryMap { data -> UIImage? in
            return UIImage(data: data)
        }
            .sink(receiveCompletion: NetworkManager.shard.handleCompletion) { [weak self] returnImage in

            // no returned image? exists
            guard let self = self, let downloadedImage = returnImage else { return }

            // there is a returned image? set self.image to it and save the image to file manager
            self.image = downloadedImage
            self.fileManager.saveImage(downloadedImage, imageName: self.imageName, folderName: self.folderName)
            self.imageSubscription?.cancel() // then cancel subscription

        }
    }
}
