//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 17/11/2021.
//

import SwiftUI

struct SearchBarView: View {

    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ?
                    .theme.secondaryText:
                    .theme.accent
            )

            TextField("Search by name or symbol", text: $searchText)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .foregroundColor(.theme.accent)
                .overlay(alignment: .trailing) {
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                    UIApplication.shared.dismesKeyboard()
                    searchText = ""
                }
            }
        }
            .font(.headline)
            .padding()
            .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.15),
                radius: 10,
                x: 0,
                y: 0)
        }
            .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
