//
//  String+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

extension String {
    
    public var IDR: String {
        return NSNumber(value: Int(self) ?? 0).toIDRCurrency()
    }
    
}
