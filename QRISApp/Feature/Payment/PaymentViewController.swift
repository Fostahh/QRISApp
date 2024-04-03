//
//  PaymentViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import UIKit

class PaymentViewController: UIViewController {

    private var currentBalance = Double(120_000)
    private let exactSubstract = Double(50_000)
    private let targetBalance = Double(70_000)
    private var animator: UIViewPropertyAnimator?
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var paymentStatusImageView: UIImageView!
    @IBOutlet private weak var paymentStatusLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decreaseMoney()
    }
    
    func decreaseMoney() {
        balanceLabel.text = "\(currentBalance.IDR)"
        
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) { [weak self] in
            guard let self else { return }
            self.currentBalance -= 1.0
            self.balanceLabel.text = "\(self.currentBalance.IDR)"
        }
        
        animator?.addCompletion({ [weak self] _ in
            guard let self else { return }
            if self.currentBalance != self.targetBalance {
                self.decreaseMoney()
            } else {
                self.balanceLabel.text = "Your current balance \(self.currentBalance.IDR)"
                self.backButton.isHidden = false
            }
        })
        
        animator?.startAnimation()
    }
    
    @IBAction private func onBackButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let animator, animator.isRunning {
            animator.stopAnimation(true)
            self.currentBalance = self.targetBalance
            self.balanceLabel.text = "Your current balance \(self.currentBalance.IDR)"
            self.backButton.isHidden = false
        }
    }
}
