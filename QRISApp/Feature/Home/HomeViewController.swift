//
//  HomeViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit
import QRISCore

class HomeViewController: UIViewController, HomeView {
    
    // MARK: Stub Properties
    var presenter: HomePresenter?
    
    private lazy var profileContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.text = "Balance"
        label.textColor = .white
        return label
    }()
    
    private lazy var balanceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var logoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "clock"), for: .normal)
        
        button.setTitle("History", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        
        button.backgroundColor = .lightGray
        button.tintColor = .white
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        button.configuration = configuration
        
        return button
    }()
    
    private lazy var payQRISButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "qrcode"), for: .normal)
        
        button.setTitle("Pay QRIS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        
        button.backgroundColor = .lightGray
        button.tintColor = .white
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        button.configuration = configuration
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchUser()
        
        view.addSubview(profileContainerView)
        view.addSubview(userImageView)
        view.addSubview(balanceTitleLabel)
        view.addSubview(balanceValueLabel)
        view.addSubview(logoutImageView)
        view.addSubview(buttonsStackView)
        view.addSubview(historyButton)
        view.addSubview(payQRISButton)
        
        NSLayoutConstraint.activate([
            profileContainerView.heightAnchor.constraint(equalToConstant: 110),
            profileContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            userImageView.heightAnchor.constraint(equalToConstant: 52),
            userImageView.widthAnchor.constraint(equalToConstant: 52),
            userImageView.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: profileContainerView.leadingAnchor, constant: 16),
            
            balanceTitleLabel.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 4),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            
            balanceValueLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 4),
            balanceValueLabel.leadingAnchor.constraint(equalTo: balanceTitleLabel.leadingAnchor),
            
            logoutImageView.heightAnchor.constraint(equalToConstant: 28),
            logoutImageView.widthAnchor.constraint(equalToConstant: 28),
            logoutImageView.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor),
            logoutImageView.trailingAnchor.constraint(equalTo: profileContainerView.trailingAnchor, constant: -16),
            
            buttonsStackView.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: 24),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        buttonsStackView.addArrangedSubview(historyButton)
        buttonsStackView.addArrangedSubview(payQRISButton)
        
        historyButton.addTarget(self, action: #selector(onHistoryButtonTapped(_:)), for: .touchUpInside)
        payQRISButton.addTarget(self, action: #selector(onQRISButtonTapped(_:)), for: .touchUpInside)
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
    
    @IBAction private func onHistoryButtonTapped(_ sender: UIButton) {
        presenter?.navigateToHistoryTransaction()
    }
    
    @IBAction private func onQRISButtonTapped(_ sender: UIButton) {
        presenter?.navigateToScanQRIS()
    }
}
