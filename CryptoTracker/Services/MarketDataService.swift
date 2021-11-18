//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

import Foundation
import Combine

class MarketDataService {

    @Published var data: MarketData?
    private var dataSubscription: AnyCancellable?

    init() {
        getData()
    }

    private func getData() {

        // url correct
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
            else { return }

        // get data using combine
        dataSubscription =
            NetworkManager.shard.download(fromURL: url) // download the data
            .decode(type: GlobalData.self, decoder: JSONDecoder()) // decode it
        .sink(receiveCompletion: // sink it with all coins property then cancel subscription
                NetworkManager.shard.handleCompletion) { [weak self] returnedData in
            self?.data = returnedData.data // now we have coins?
            self?.dataSubscription?.cancel()
        }
    }
}
