//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 17/11/2021.
//

import SwiftUI

struct StatisticView: View {

    let stat: Statistic

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)

            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)

            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))

                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
                .foregroundColor((stat.percentageChange ?? 0) >= 0 ? .theme.green : .theme.red)
                .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat1)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        StatisticView(stat: dev.stat2)
            .previewLayout(.sizeThatFits)
        StatisticView(stat: dev.stat3)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
