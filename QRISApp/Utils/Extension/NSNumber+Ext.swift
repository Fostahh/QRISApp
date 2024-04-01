//
//  NSNumber+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

extension NSNumber {
    
    public func toIDRCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = "."

        guard let number = formatter.string(from: self) else {
            return ""
        }

        return "Rp\(number)"
    }
    
}
