//
//  User.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

struct User {
    var id: Int = 0
    var username: String = ""
    var balance: Double = 0
    var transactions: [User.Transaction] = []
    
    struct Transaction {
        let id: Int
        let merchant: String
        let fee: Double
    }
}
