//
//  PaymentViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import UIKit
import QRISCore

class PaymentViewController: UIViewController, PaymentView {
    
    var presenter: PaymentPresenter?
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var paymentStatusImageView: UIImageView!
    @IBOutlet private weak var paymentStatusLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction private func onBackButtonTapped(_ sender: UIButton) {
        presenter?.backToHomeScreen()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.onTouchesBegan()
    }
    
    func configViews(_ balance: String, _ paymentStatus: Payment.PaymentStatus) {
        balanceLabel.text = balance
        
        switch paymentStatus {
        case .success:
            paymentStatusImageView.image = UIImage(named: "img-payment-success")
        case .failed:
            paymentStatusLabel.text = "Payment Failed"
            paymentStatusImageView.image = UIImage(named: "img-payment-failed")
            backButton.isHidden = false
        }
    }
    
    func updateBalanceLabel(_ balance: String, finished: Bool) {
        if finished {
            balanceLabel.text = "Your current balance \(balance)"
            backButton.isHidden = false
        } else {
            balanceLabel.text = balance
        }
    }
}
