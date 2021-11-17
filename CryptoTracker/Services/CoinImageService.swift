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

    init(coin: Coin) {
        self.coin = coin
        getSavedImage()
    }

    private func getSavedImage() {
        if let image = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            self.image = image
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        print("downloading image")
        guard let url = URL(string: coin.image) else { return }

        imageSubscription =
            NetworkManager.shard.download(fromURL: url)
            .tryMap { data -> UIImage? in
            return UIImage(data: data)
        }
            .sink(receiveCompletion: NetworkManager.shard.handleCompletion) { [weak self] returnImage in
            if
                let self = self,
                let image = returnImage {
                self.image = image
                self.fileManager.saveImage(image, imageName: self.coin.id, folderName: self.folderName)
                self.imageSubscription?.cancel()
            }
        }
    }
}
