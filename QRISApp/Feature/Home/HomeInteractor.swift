//
//  HomeInteractor.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

protocol HomeInteractor: BaseInteractor {
    func getUser(completion: (Result<User, Error>) -> Void)
}

class HomeInteractorImpl: HomeInteractor {
    func getUser(completion: (Result<User, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "response_user", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            print("userResponse: \(userResponse)")
            completion(.success(userResponse.toUser))
        } catch {
            completion(.failure(error))
        }
    }
}
