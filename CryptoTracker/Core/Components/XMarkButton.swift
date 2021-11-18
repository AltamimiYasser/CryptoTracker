//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 18/11/2021.
//

import SwiftUI

struct XMarkButton: View {

    @Binding var dismiss: Bool

    var body: some View {
        Button {
            dismiss.toggle()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton(dismiss: .constant(false))
    }
}
