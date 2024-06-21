//
//  PaymentPresenter.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import UIKit
import QRISCore

protocol PaymentPresenter: BasePresenter {
    func backToHomeScreen()
    func viewDidLoad()
    func onTouchesBegan()
}

class PaymentPresenterImpl: PaymentPresenter {
    let router: PaymentRouter
    let interactor: PaymentInteractor
    weak var view: PaymentView?
    
    private var animator: UIViewPropertyAnimator?
    
    private let payment: Payment
    private let targetBalance: Double
    private var currentBalance: Double
    
    init(router: PaymentRouter, interactor: PaymentInteractor, view: PaymentView, payment: Payment) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.payment = payment
        self.currentBalance = interactor.getUserBalance()
        self.targetBalance = currentBalance - payment.fee
    }
    
    func backToHomeScreen() {
        router.backToHomeScreen()
    }
    
    func viewDidLoad() {
        switch payment.paymentStatus {
        case .success:
            view?.configViews(currentBalance.IDR, payment.paymentStatus)
            decreaseMoney()
        case .failed:
            view?.configViews(currentBalance.IDR, payment.paymentStatus)
        }
        
    }
    
    private func decreaseMoney() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) { [weak self] in
            guard let self else { return }
            self.currentBalance -= 1.0
            self.view?.updateBalanceLabel(self.currentBalance.IDR, finished: false)
        }
        
        animator?.addCompletion({ [weak self] _ in
            guard let self else { return }
            
            if self.currentBalance != self.targetBalance {
                self.decreaseMoney()
            } else {
                self.view?.updateBalanceLabel(self.currentBalance.IDR, finished: true)
                self.interactor.updateUserBalance(self.currentBalance)
            }
        })
        
        animator?.startAnimation()
    }
    
    func onTouchesBegan() {
        if let animator, animator.isRunning {
            animator.stopAnimation(true)
            view?.updateBalanceLabel(targetBalance.IDR, finished: true)
            interactor.updateUserBalance(currentBalance)
        }
    }
    
}
