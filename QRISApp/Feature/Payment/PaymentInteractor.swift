//
//  PaymentInteractor.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

protocol PaymentInteractor: BaseInteractor {
    func getUserBalance() -> Double
    func updateUserBalance(_ balance: Double)
}

class PaymentInteractorImpl: PaymentInteractor {
    
    private let userDefaultModel = UserDefaultModelImpl.sharedInstance
    
    func getUserBalance() -> Double {
        userDefaultModel.getUser()?.balance ?? 0
    }
    
    func updateUserBalance(_ balance: Double) {
        guard let currentUser = userDefaultModel.getUser() else { return }
        userDefaultModel.setUser(
            User(id: currentUser.id,
                 username: currentUser.username,
                 balance: balance
                ).toEntity
        )
    }
}
