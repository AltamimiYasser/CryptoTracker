//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 15/11/2021.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State var showPortfolio = false

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background

            // content layer
            VStack {

                // header
                homeHeader

                // columns titles
                columnsHeaders
                
                // search bar
                SearchBarView(searchText: $vm.searchText)

                // List
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)

            }
                .preferredColorScheme(.dark)
                .environmentObject(dev.homeVM)

            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
                .environmentObject(dev.homeVM)
        }
    }
}

// MARK: - Extension
extension HomeView {
    private var homeHeader: some View {

        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background {
                CircleButtonAnimationView(animated: $showPortfolio)
            }

            Spacer()

            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: showPortfolio)


            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                withAnimation(.spring()) {
                    showPortfolio.toggle()
                }
            }
        }
            .padding(.horizontal)
    }

    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
            .listStyle(.plain)
    }

    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
            .listStyle(.plain)
    }

    private var columnsHeaders: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.1, alignment: .trailing)
        }
            .font(.caption)
            .foregroundColor(.theme.secondaryText)
            .padding(.horizontal)
    }
}
