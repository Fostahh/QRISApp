//
//  HomeRouter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import UIKit

protocol HomeRouter {
    func navigateToScanQRIS()
    func navigateToHistoryTransaction()
}

class HomeRouterImpl: HomeRouter {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let router = HomeRouterImpl()
        let view = HomeViewController()
        let interactor = HomeInteractorImpl()
        let presenter = HomePresenterImpl(router: router, interactor: interactor, view: view)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToScanQRIS() {
        let viewController = ScanQRISRouterImpl.createModule()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToHistoryTransaction() {
        let viewController = HistoryTransactionsRouterImpl.createModule()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
