//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var statistics = [Statistic]()

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText = ""

    private let coinService = CoinDataService()
    private let marketService = MarketDataService()
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

        // subscribe to marketDataService
        marketService.$data
            .map { data -> [Statistic] in
            var stats = [Statistic]()

            guard let data = data else { return stats }
            let cap = Statistic(
                title: "Market Cap",
                value: data.MarketCap,
                percentageChange: data.marketCapChangePercentage24HUsd)
            let volum = Statistic(title: "24h Volume", value: data.volume)
            let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
            let portfolio = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0)

            stats.append(contentsOf: [
                cap, volum, btcDominance, portfolio
                ])
            return stats
        }
            .sink { [weak self] receivedStats in
                self?.statistics = receivedStats
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
