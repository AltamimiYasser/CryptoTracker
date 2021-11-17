//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 17/11/2021.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {

    @Published var image: UIImage?
    @Published var isLoading = false

    private let coin: Coin
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()


    init(coin: Coin) {
        self.coin = coin
        coinImageService = CoinImageService(coin: coin)
        addSubscribers()
        isLoading = true
    }

    private func addSubscribers() {
        coinImageService.$image
            .sink(receiveCompletion: { [weak self] _ in
            self?.isLoading = false
        }, receiveValue: { image in
                self.image = image
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
