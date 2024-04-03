//
//  UserResponse.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

struct UserResponse: Codable {
    let id: Int
    let username: String
    let balance: Double
    let transactions: [UserResponse.Transaction]
    
    struct Transaction: Codable {
        let id: Int
        let merchant: String
        let fee: Double
    }
    
}

extension UserResponse {
    var toUser: User {
//        var transactions = [User.Transaction]()
//        self.transactions.forEach { transactions.append(User.Transaction(id: $0.id, merchant: $0.merchant, fee: $0.fee)) }
        
        return User(
            id: self.id,
            username: self.username,
            balance: self.balance,
            transactions: self.transactions.compactMap({ User.Transaction(id: $0.id, merchant: $0.merchant, fee: $0.fee) })
        )
    }
}
