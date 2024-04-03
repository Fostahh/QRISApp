//
//  ScanQRISPresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

protocol ScanQRISPresenter: BasePresenter {
    func backToHomeScreen()
}

class ScanQRISPresenterImpl: ScanQRISPresenter {
    let router: ScanQRISRouter?
    let interactor: ScanQRISInteractor?
    weak var view: ScanQRISView?
    
    init(router: ScanQRISRouter?, interactor: ScanQRISInteractor?, view: ScanQRISView? = nil) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    func backToHomeScreen() {
        router?.popToHomeScreen()
    }
}
