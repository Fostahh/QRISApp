//
//  HomePresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

protocol HomePresenter: BasePresenter {
    var router: Router? { get set }
    var interactor: Interactor? { get set }
    var view: HomeView? { get set }
    
    func fetchUser()
    func interactorDidFetchUsers(with result: Result<User, Error>)
    func navigateToScanQRISScreen()
}

class HomePresenterImpl: HomePresenter {
    var router: Router?
    var interactor: Interactor?
    var view: HomeView?
    
    func fetchUser() {
        interactor?.getUser()
    }
    
    func interactorDidFetchUsers(with result: Result<User, Error>) {
        switch result {
        case .success(let success):
            self.view?.update(with: success)
        case .failure(let failure):
            self.view?.update(with: failure.localizedDescription)
        }
    }
    
    func navigateToScanQRISScreen() {
        router?.navigateToNextScreen()
    }
}
