//
//  CoinRowView.swift.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import SwiftUI

struct CoinRowView: View {

    let coin: Coin
    let showHoldingColumn: Bool

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()

            if showHoldingColumn {
                middleColumn
            }

            rightColumn
        }
            .font(.subheadline)
    }
}


// MARK: - Extension of Views
extension CoinRowView {
    var leftColumn: some View {
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

        }
    }

    var middleColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
            .foregroundColor(.theme.accent)
    }

    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(.theme.accent)

            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
                .foregroundColor(// change color if price change is moving up or down
                (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    .theme.green:
                    .theme.red
            )
        }
            .frame(width: UIScreen.main.bounds.width / 3.1, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
