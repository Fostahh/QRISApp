//
//  PaymentRouter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import UIKit
import QRISCore

protocol PaymentRouter {
    func backToHomeScreen()
}

class PaymentRouterImpl: PaymentRouter {
    weak var viewController: UIViewController?
    
    static func createModule(payment: Payment) -> UIViewController {
        let router = PaymentRouterImpl()
        let view = PaymentViewController()
        let interactor = PaymentInteractorImpl()
        let presenter = PaymentPresenterImpl(router: router, interactor: interactor, view: view, payment: payment)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func backToHomeScreen() {
        self.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
