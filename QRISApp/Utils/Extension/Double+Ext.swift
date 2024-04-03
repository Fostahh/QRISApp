//
//  Double+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

extension Double {
    public var IDR: String {
        return NSNumber(value: Int(self)).toIDRCurrency()
    }
}
