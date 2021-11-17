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
    @Published var searchText = ""

    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscription()
    }

    func addSubscription() {

        // subscribe to searchText and allCoins in the coinService
        $searchText
            .combineLatest(coinService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        .map(filterSearch)
        .sink { [weak self] filteredCoins in
            self?.allCoins = filteredCoins
        }
            .store(in: &cancellables)
    }

    // filter search
    private func filterSearch(searchText: String, oldCoins: [Coin]) -> [Coin] {
        guard !searchText.isEmpty else { return oldCoins }
        
        // filter on lower cased text with the coin name, symbol and id
        return oldCoins.filter { coin in
            coin.name.lowercased().contains(searchText.lowercased())
                || coin.symbol.lowercased().contains(searchText.lowercased())
                || coin.id.lowercased().contains(searchText.lowercased())
        }
    }
}
