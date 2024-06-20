//
//  UserDefault.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

public protocol UserDefaultModel {
    func setUser(_ userEntity: UserEntity)
    func getUser() -> User?
}

public class UserDefaultModelImpl: UserDefaultModel {
    
    public static let sharedInstance = UserDefaultModelImpl()
    
    private static let userKey = "userKey"
    
    public func setUser(_ userEntity: UserEntity) {
        if let encodedData = try? JSONEncoder().encode(userEntity) {
            UserDefaults.standard.set(encodedData, forKey: UserDefaultModelImpl.userKey)
        }
    }
    
    public func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultModelImpl.userKey) {
            let decoder = JSONDecoder()
            if let userEntity = try? decoder.decode(UserEntity.self, from: data) {
                return userEntity.toUser
            }
        }
        return nil
    }
    
}
