//
//  User.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

public struct User {
    public let id: Int
    public let username: String
    public let balance: Double
    
    public init(id: Int, username: String, balance: Double) {
        self.id = id
        self.username = username
        self.balance = balance
    }
}

public extension User {
    var toEntity: UserEntity {
        UserEntity(
            id: id,
            username: username,
            balance: balance
        )
    }
}
