//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject var vm: HomeViewModel
    @Binding var isShowingPortfolioView: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)

                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHStack(spacing: 10) {
                            ForEach(vm.allCoins) { coin in
                                Text(coin.symbol.uppercased())
                            }
                        }
                    }
                }
            }
                .navigationTitle("Edit Portfolio")
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: $isShowingPortfolioView)
                } }
        }
    }
}


struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(isShowingPortfolioView: .constant(true))
            .environmentObject(dev.homeVM)
    }
}
