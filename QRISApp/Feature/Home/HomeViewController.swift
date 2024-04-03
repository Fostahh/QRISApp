//
//  HomeViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit

class HomeViewController: UIViewController, HomeView {
    
    // MARK: Stub Properties
    var presenter: HomePresenter?
    
    // MARK: IBOutlets
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var balanceTitleLabel: UILabel!
    @IBOutlet private weak var balanceValueLabel: UILabel!
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var payQRISButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: Stub Methods
    func update(with user: User) {
        userImageView.image = UIImage(named: "bobi")
        balanceTitleLabel.text = "Hi, welcome back \(user.username)!"
        balanceValueLabel.text = user.balance.IDR
    }
    
    func update(with error: String) {
        // MARK: TODO
    }

    // MARK: IBActions
    @IBAction private func onHistoryButtonTapped(_ sender: UIButton) {
        presenter?.navigateToHistoryTransaction()
    }
    
    @IBAction private func onPayQRISButtonTapped(_ sender: UIButton) {
        presenter?.navigateToScanQRIS()
    }
}
