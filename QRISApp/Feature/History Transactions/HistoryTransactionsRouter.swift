//
//  HistoryTransactionsRouter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import UIKit

protocol HistoryTransactionsRouter {
    func backToHomeScreen()
}

class HistoryTransactionsRouterImpl: HistoryTransactionsRouter {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let router = HistoryTransactionsRouterImpl()
        let view = HistoryTransactionsViewController()
        let interactor = HistoryTransactionsInteractorImpl()
        let presenter = HistoryTransactionsPresenterImpl(router: router, interactor: interactor, view: view)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func backToHomeScreen() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
