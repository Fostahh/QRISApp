//
//  HomeViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var balanceTitleLabel: UILabel!
    @IBOutlet private weak var balanceValueLabel: UILabel!
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var payQRISButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsLocalize()
    }
    
    private func configureViewsLocalize() {
        balanceTitleLabel.text = "Balance"
        historyButton.setTitle("History", for: .normal)
        payQRISButton.setTitle("Pay QRIS", for: .normal)
    }

    @IBAction private func onHistoryButtonTapped(_ sender: UIButton) {
        print("Ini \(#function)")
    }
    
    @IBAction private func onPayQRISButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(ScanQRISViewController(), animated: true)
    }
}
