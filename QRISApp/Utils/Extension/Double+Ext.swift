//
//  Double+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

extension Double {
    
    var IDR: String {
        return NSNumber(value: Int(self)).toIDRCurrency()
    }
    
    var toTimeStamp: String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
}
