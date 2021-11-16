//
//  Double.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import Foundation

extension Double {
    
    /// Convert a `Double` into a currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1234,56
    /// Convert 12.3456 to $12,3456
    /// Convert 0.123456 to $0,123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "SAR"
        formatter.currencySymbol = "SR"
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 6
        return formatter
    }
    
        /// Convert a `Double` into a currency as a `String` with 2-6 decimal places
        /// ```
        /// Convert 1234.56 to "$1234,56"
        /// Convert 12.3456 to "$12,3456"
        /// Convert 0.123456 to "$0,123456"
        /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a `Double` into a `String`
    /// ```
    /// Convert 1.23456 to "1.23"
    /// ```
    func asNumberString() -> String {
        String(format: "%.2f", self)
    }
    
    /// Convert a `Double` into a `String` with the percentage symbol
    /// ```
    /// Convert 1.23456 to "1.23%"
    /// ```
    func asPercentString() -> String {
        String(format: "%.2f", self) + "%"
    }
}
