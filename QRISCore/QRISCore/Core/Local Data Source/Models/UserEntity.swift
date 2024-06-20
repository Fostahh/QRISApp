//
//  UserEntity.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

struct UserEntity: Codable {
    let id: Int
    let username: String
    let balance: Double
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
