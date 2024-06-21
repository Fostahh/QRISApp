//
//  PaymentView.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation
import QRISCore

protocol PaymentView: BaseView {
    var presenter: PaymentPresenter? { get set }
    
    func configViews(_ balance: String, _ paymentStatus: Payment.PaymentStatus)
    func updateBalanceLabel(_ balance: String, finished: Bool)
}
