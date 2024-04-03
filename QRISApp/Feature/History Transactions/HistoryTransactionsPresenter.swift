//
//  HistoryTransactionsPresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

protocol HistoryTransactionsPresenter: BasePresenter {
    func backToHomeScreen()
    func fetchHistoryTransactions()
}

class HistoryTransactionsPresenterImpl: HistoryTransactionsPresenter {
    let router: HistoryTransactionsRouter
    let interactor: HistoryTransactionsInteractor
    weak var view: HistoryTransactionsView?
    
    init(router: HistoryTransactionsRouter, interactor: HistoryTransactionsInteractor, view: HistoryTransactionsView?) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    func fetchHistoryTransactions() {
        interactor.getHistoryTransactions { [weak self] result in
            switch result {
            case .success(let success):
                self?.view?.populateTableView(success)
            case .failure(let failure):
                self?.view?.showError(failure.localizedDescription)
            }
        }
    }
    
    func backToHomeScreen() {
        router.backToHomeScreen()
    }
}
