//
//  ScanQRISPresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation

protocol ScanQRISPresenter: BasePresenter {
    var router: Router? { get set }
    var interactor: Interactor? { get set }
    var view: ScanQRISView? { get set }
    
    func backToHomeScreen()
}

class ScanQRISPresenterImpl: ScanQRISPresenter {
    var router: Router?
    var interactor: Interactor?
    var view: ScanQRISView?
    
    func backToHomeScreen() {
        router?.backToHomeScreen()
    }
}
