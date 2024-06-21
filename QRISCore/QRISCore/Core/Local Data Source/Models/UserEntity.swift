//
//  UserEntity.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

public struct UserEntity: Codable {
    public let id: Int
    public let username: String
    public let balance: Double
}

extension UserEntity {
    var toUser: User {
        User(
            id: id,
            username: username,
            balance: balance
        )
    }
}
