//
//  HomeStatView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

import SwiftUI

struct HomeStatView: View {

    @EnvironmentObject var vm: HomeViewModel

    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment:
                showPortfolio ? .trailing : .leading
        )
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
