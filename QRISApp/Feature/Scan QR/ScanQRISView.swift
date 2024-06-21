//
//  ScanQRISView.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import Foundation
import QRISCore_Base

protocol ScanQRISView: BaseView {
    var presenter: ScanQRISPresenter? { get set }
    
    func configCamera()
    func showPermissionAlert()
    func showDetailTransaction(_ merchant: String, _ nominal: String, _ id: String)
}
