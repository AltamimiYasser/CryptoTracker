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
    private let portfolioService = PortfolioDataService()

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
            .map(mapGlobalMarketData)
            .sink { [weak self] receivedStats in
            self?.statistics = receivedStats
        }
            .store(in: &cancellables)

        // subscribe to portfolio coins in portfolioDataService && all coins in dataService
        $allCoins
            .combineLatest(portfolioService.$savedEntities)
            .map { coins, portfolioEntity -> [Coin] in
            coins.compactMap { coin -> Coin? in
                guard let entity = portfolioEntity.first(where: { $0.coinId == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
        }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
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

    // map for the market data subscription
    private func mapGlobalMarketData(data: MarketData?) -> [Statistic] {
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
}
