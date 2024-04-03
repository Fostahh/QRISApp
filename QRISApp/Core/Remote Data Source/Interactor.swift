//
//  Interactor.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

protocol Interactor {
    var presenter: HomePresenter? { get set }
    
    func getUser()
}

class InteractorImpl: Interactor {
    var presenter: HomePresenter?
    
    func getUser() {
        guard let path = Bundle.main.path(forResource: "response_user", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            print("userResponse: \(userResponse)")
            self.presenter?.interactorDidFetchUsers(with: .success(userResponse.toUser))
        } catch {
            self.presenter?.interactorDidFetchUsers(with: .failure(error))
        }
    }
    
}
