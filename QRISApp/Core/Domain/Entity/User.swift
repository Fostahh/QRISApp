//
//  User.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

struct User {
    let id: Int
    let username: String
    let balance: Double
}

extension User {
    var toUserEntity: UserEntity {
        UserEntity(
            id: id,
            username: username,
            balance: balance
        )
    }
}
