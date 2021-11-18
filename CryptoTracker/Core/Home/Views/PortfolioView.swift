//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

import SwiftUI
import Combine

struct PortfolioView: View {

    @EnvironmentObject var vm: HomeViewModel
    @Binding var isShowingPortfolioView: Bool
    @State private var selectedCoin: Coin?
    @State private var quantityText = ""
    @State private var showCheckmark = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                        .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            XMarkButton(dismiss: $isShowingPortfolioView)
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Edit Portfolio")
                                .font(.title)
                                .bold()
                                .foregroundColor(.theme.accent)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            navigationSaveButton
                        }
                    }
                        .onChange(of: vm.searchText) { newValue in
                            if newValue == "" {
                                removeSelectedCoin()
                            }
                        }

                    if let selectedCoin = selectedCoin {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Current price of: \(selectedCoin.name)")
                                Spacer()
                                Text(selectedCoin.currentPrice.asCurrencyWith6Decimals())
                            }
                            Divider()
                            HStack {
                                Text("Amount holding:")
                                Spacer()
                                TextField("Ex: 1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .onReceive(Just(quantityText)) { newValue in
                                    let filtered = newValue.filter { "0123456789.".contains($0) }
                                    if filtered != newValue {
                                        quantityText = filtered
                                    }
                                }
                            }
                            Divider()
                            HStack {
                                Text("Current Value:")
                                Spacer()
                                Text(calculateCurrentValue().asCurrencyWith2Decimals())
                            }
                        }
                            .padding()
                            .font(.headline)
                    }
                }
            }
        }
    }
}


struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(isShowingPortfolioView: .constant(true))
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                        selectedCoin = coin
                    }
                        .background {

                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin == coin ?
                                .theme.green: Color.clear,
                            lineWidth: 1)
                            .animation(.easeInOut, value: selectedCoin)
                    }
                }
            }
                .padding(.vertical, 4)
                .padding(.leading)
        }
    }

    private var navigationSaveButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
                .animation(.easeInOut, value: showCheckmark)

            Button {
                saveToPortfolio()
            } label: {
                Text("save".uppercased())
            }
                .opacity(
                selectedCoin != nil &&
                    selectedCoin?.currentHoldings != Double(quantityText) ?
                1.0: 0.0
            )

        }
            .font(.headline)
    }

    private func saveToPortfolio() {
        guard let coin = selectedCoin else { return }

        // save to portfolio

        // show the checkmark
        showCheckmark = true

        // remove selected coin
        removeSelectedCoin()

        // dismiss keyboard
        UIApplication.shared.dismesKeyboard()

        // hide checkmark after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showCheckmark = false
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }

    private func calculateCurrentValue() -> Double {
        if
            let quantity = Double(quantityText),
            let selectedCoin = selectedCoin {
            return quantity * selectedCoin.currentPrice
        }
        return 0
    }
}
