//
//  Router.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation
import UIKit

typealias EntryPoint = BaseView & UIViewController

protocol Router {
    var entry: EntryPoint? { get }
    
    static func start() -> Router
    func navigateToNextScreen()
    func backToHomeScreen()
}

class RouterImpl: Router {
    
    var entry: EntryPoint?
    
    static func start() -> Router {
        let router = RouterImpl()
        
        let view = HomeViewController()
        let presenter = HomePresenterImpl()
        var interactor: Interactor = InteractorImpl()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func navigateToNextScreen() {
        guard let entry = entry else {
            return
        }
        let scanQRISViewController = ScanQRISViewController()
        entry.present(scanQRISViewController, animated: true)
//        entry.navigationController?.pushViewController(scanQRISViewController, animated: true)
    }
    
    func backToHomeScreen() {
        guard let entry else { return }
        entry.navigationController?.popViewController(animated: true)
    }
}
