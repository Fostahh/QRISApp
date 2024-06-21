//
//  HomePresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation
import QRISCore_Base

protocol HomePresenter: BasePresenter {
    func fetchUser()
    func navigateToScanQRIS(view: HomeView?)
    func navigateToHistoryTransaction(view: HomeView?)
}

class HomePresenterImpl: HomePresenter {
    let router: HomeRouter
    let interactor: HomeInteractor
    weak var view: HomeView?
    
    init(router: HomeRouter, interactor: HomeInteractor, view: HomeView?) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    func fetchUser() {
        interactor.getUser { [weak self] result in
            switch result {
            case .success(let success):
                self?.view?.update(with: success)
            case .failure(let failure):
                self?.view?.update(with: failure.localizedDescription)
            }
        }
    }
    
    func navigateToScanQRIS(view: HomeView?) {
        router.navigateToScanQRIS(view: view)
    }
    
    func navigateToHistoryTransaction(view: HomeView?) {
        router.navigateToHistoryTransaction(view: view)
    }
}
