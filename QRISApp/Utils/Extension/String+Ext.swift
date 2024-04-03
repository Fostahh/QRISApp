//
//  String+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

extension String {
    var IDR: String {
        return NSNumber(value: Int(self) ?? 0).toIDRCurrency()
    }
}

extension Substring {
    var toInt: Int {
        return Int(String(self)) ?? 0
    }
}
