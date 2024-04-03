//
//  HomeRouter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import UIKit

protocol HomeRouter {
    func navigateToScanQRIS()
}

class LoginRouter {
    var navController: UINavigationController?
}

class HomeRouterImpl: HomeRouter {
    var navController: UINavigationController?
    
    static func createModule() -> UIViewController {
        let router = HomeRouterImpl()
        let view = HomeViewController()
        let interactor = HomeInteractorImpl()
        let presenter = HomePresenterImpl(router: router, interactor: interactor, view: view)
        
        let navController = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        router.navController = navController
        
        return navController
    }
    
    func navigateToScanQRIS() {
        let viewController = ScanQRISRouterImpl.createModule()
        self.navController?.pushViewController(viewController, animated: true)
    }
}
