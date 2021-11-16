//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
   
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscription()
    }
    
    func addSubscription() {
        coinService.$allCoins
            .sink { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
            }
            .store(in: &cancellables)
    }
}
