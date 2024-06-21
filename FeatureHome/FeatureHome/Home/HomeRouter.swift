//
//  HomeRouter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import UIKit

public protocol HomeNavigation: AnyObject {
    func fromHomeToScanQRIS(_ viewController: UIViewController)
    func fromHomeToHistoryTransaction(_ viewController: UIViewController)
}

public class HomeConfigurator {
    
    public static let shared = HomeConfigurator()
    public weak var delegate: HomeNavigation?
    
    public func createHomeScene() -> UIViewController {
        let router = HomeRouterImpl()
        let view = HomeViewController()
        let interactor = HomeInteractorImpl()
        let presenter = HomePresenterImpl(router: router, interactor: interactor, view: view)
        
        view.presenter = presenter
        
        return view
    }
    
}

protocol HomeRouter {
    func navigateToScanQRIS(view: HomeView?)
    func navigateToHistoryTransaction(view: HomeView?)
}

class HomeRouterImpl: HomeRouter {
    
    func createModule() -> UIViewController {
        let router = HomeRouterImpl()
        let view = HomeViewController()
        let interactor = HomeInteractorImpl()
        let presenter = HomePresenterImpl(router: router, interactor: interactor, view: view)
        
        view.presenter = presenter
        
        return view
    }
    
    func navigateToScanQRIS(view: HomeView?) {
        guard let viewController = view as? UIViewController else { return }
        print("INI DIA A \(#function)")
        HomeConfigurator.shared.delegate?.fromHomeToScanQRIS(viewController)
    }
    
    func navigateToHistoryTransaction(view: HomeView?) {
        guard let viewController = view as? UIViewController else { return }
        print("INI DIA A \(#function)")
        HomeConfigurator.shared.delegate?.fromHomeToHistoryTransaction(viewController)
    }
    
}
