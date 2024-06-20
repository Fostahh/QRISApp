//
//  UserDefault.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

protocol UserDefaultModel {
    func setUser(_ userEntity: UserEntity)
    func getUser() -> User?
}

class UserDefaultModelImpl: UserDefaultModel {
    
    static let sharedInstance = UserDefaultModelImpl()
    
    private static let userKey = "userKey"
    
    func setUser(_ userEntity: UserEntity) {
        if let encodedData = try? JSONEncoder().encode(userEntity) {
            UserDefaults.standard.set(encodedData, forKey: UserDefaultModelImpl.userKey)
        }
    }
    
    func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultModelImpl.userKey) {
            let decoder = JSONDecoder()
            if let userEntity = try? decoder.decode(UserEntity.self, from: data) {
                return userEntity.toUser
            }
        }
        return nil
    }
    
}
