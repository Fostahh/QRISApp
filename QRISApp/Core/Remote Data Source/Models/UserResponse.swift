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
}

extension UserResponse {
    
    var toEntity: UserEntity {
        UserEntity(id: id, username: username, balance: balance)
    }
    
    var toDomain: User {
        User(id: id, username: username, balance: balance)
    }
    
}
