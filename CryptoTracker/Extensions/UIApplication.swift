//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 17/11/2021.
//

import SwiftUI

extension UIApplication {
    func dismesKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
