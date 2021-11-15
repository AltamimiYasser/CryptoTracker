//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 15/11/2021.
//

import SwiftUI

struct HomeView: View {

    @State var showPortfolio = false

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background

            // content layer
            VStack {
                homeHeader
                
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

            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
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
}
