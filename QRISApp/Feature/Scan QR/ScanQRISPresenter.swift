//
//  ScanQRISPresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

protocol ScanQRISPresenter: BasePresenter {
    func backToHomeScreen()
    func requestCameraAccess()
    func processOutput(string: String)
    func requestProcessPayment()
    func navigateToPaymentScreen(payment: Payment)
}

class ScanQRISPresenterImpl: ScanQRISPresenter {
    let router: ScanQRISRouter
    let interactor: ScanQRISInteractor
    weak var view: ScanQRISView?
    
    private var id = 0
    
    init(router: ScanQRISRouter, interactor: ScanQRISInteractor, view: ScanQRISView) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    func requestCameraAccess() {
        interactor.requestCameraAccess(completion: { [weak self] granted in
            if granted {
                self?.view?.configCamera()
            } else {
                self?.view?.showPermissionAlert()
            }
        })
    }
    
    func processOutput(string: String) {
        let valueComponents = string.components(separatedBy: ".")
        
        if valueComponents.count == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
                let id = valueComponents[1].dropFirst(2).toInt
                self?.id = id
                self?.view?.showDetailTransaction(
                    "Merchant Name \(valueComponents[2])",
                    "Transaction Nominal \(valueComponents[3].IDR)",
                    "Transaction ID \(id)"
                )
            }
            
        }
    }
    
    func requestProcessPayment() {
        interactor.requestProcessPayment(id: self.id, completion: { [weak self] result in
            switch result {
            case .success(let success):
                self?.navigateToPaymentScreen(payment: success)
            case .failure(let failure):
                
                print("Ini \(#function) \(failure.localizedDescription)")
            }
        })
    }
    
    func backToHomeScreen() {
        router.popToHomeScreen()
    }
    
    func navigateToPaymentScreen(payment: Payment) {
        router.navigateToPaymentScreen(payment: payment)
    }
}
