//
//  Coin.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 15/11/2021.
//

// ConinGecko API Info:
/*
URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=sar&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 Response:
[
     {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 240377,
     "market_cap": 4543787252356,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 5055532038518,
     "total_volume": 118861518403,
     "high_24h": 248895,
     "low_24h": 239855,
     "price_change_24h": -1063.49190136898,
     "price_change_percentage_24h": -0.44048,
     "market_cap_change_24h": -8523060581.276367,
     "market_cap_change_percentage_24h": -0.18722,
     "circulating_supply": 18874281,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 258938,
     "ath_change_percentage": -6.99974,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 646.04,
     "atl_change_percentage": 37175.28089,
     "atl_date": "2015-01-14T00:00:00.000Z",
     "roi": null,
     "last_updated": "2021-11-15T21:04:16.329Z",
     "sparkline_in_7d": {
         "price": [
             66216.67656777156,
             66040.60747437927,
             65981.19614082146,
             65083.05923377397,
             64631.56904086273,
             64282.84963072226
             ]
         },
     "price_change_percentage_24h_in_currency": -0.4404777766000248
     },
     {
     ... same
     }
]

 */

import Foundation
import SwiftUI

// MARK: - Coin
struct Coin: Identifiable, Codable, Equatable {
    static func == (lhs: Coin, rhs: Coin) -> Bool {
        lhs.id == rhs.id
    }

    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    // we are doing this so we don't mutate data but create a new model and return it
    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice,
                    marketCap: marketCap, marketCapRank: marketCapRank,
                    fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume,
                    high24H: high24H, low24H: low24H, priceChange24H: priceChange24H,
                    priceChangePercentage24H: priceChangePercentage24H,
                    marketCapChange24H: marketCapChange24H,
                    marketCapChangePercentage24H: marketCapChangePercentage24H,
                    circulatingSupply: circulatingSupply, totalSupply: totalSupply,
                    maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage,
                    athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage,
                    atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D,
                    priceChangePercentage24HInCurrency: priceChangePercentage24H,
                    currentHoldings: amount)
    }
    
    // current holdings value is the current holdings * current price
    var currentHoldingsValue: Double {
        (currentHoldings ?? 0) * currentPrice // if current holdings is 0 then 0 * price is always 0
    }
    
    var rank: Int {
       Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
