//
//  CoinRowView.swift.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import SwiftUI

struct CoinRowView_swift: View {
    let coin: Coin
    var body: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)

            Circle()
                .frame(width: 30, height: 30)

            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)

            Spacer()

            VStack {
                Text("\(coin.currentPrice)")
                    .bold()
                    .foregroundColor(.theme.accent)

                Text("\(coin.priceChangePercentage24H ?? 0)%")
                    .foregroundColor(// change color if price change is moving up or down
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        .theme.green:
                        .theme.red
                )
            }
        }
    }
}

struct CoinRowView_swift_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView_swift(coin: dev.coin)
    }
}
