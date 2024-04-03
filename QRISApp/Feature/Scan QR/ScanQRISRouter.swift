//
//  ScanQRISRouter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import UIKit

protocol ScanQRISRouter {
    func popToHomeScreen()
    func navigateToPaymentScreen(payment: Payment)
}

class ScanQRISRouterImpl: ScanQRISRouter {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let router = ScanQRISRouterImpl()
        let view = ScanQRISViewController()
        let interactor = ScanQRISInteractorImpl()
        let presenter = ScanQRISPresenterImpl(router: router, interactor: interactor, view: view)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func popToHomeScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToPaymentScreen(payment: Payment) {
        let viewController = PaymentRouterImpl.createModule(payment: payment)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
