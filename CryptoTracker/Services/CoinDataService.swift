//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import Foundation
import Combine

class CoinDataService {

    @Published var allCoins: [Coin] = []
    private var coinSubscription: AnyCancellable?

    init() {
        getAllCoins()
    }

    private func getAllCoins() {

        // url currect
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=sar&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
            else { return }

        // get data using combine
        coinSubscription = NetworkManager.shard.download(fromURL: url)
            .decode(type: [Coin].self, decoder: JSONDecoder()) // decode it
        .sink { completion in // make sure data received and assign it to all coins

            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] returnedCoins in
            self?.allCoins = returnedCoins // now we have coins?
            self?.coinSubscription?.cancel()
        }
    }
}
