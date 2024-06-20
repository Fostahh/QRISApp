//
//  HistoryTransactionsViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import UIKit
import RxSwift
import RxCocoa
import QRISCore

class HistoryTransactionsViewController: UIViewController, HistoryTransactionsView {
    
    // MARK: Stub Properties
    var presenter: HistoryTransactionsPresenter?
    
    // MARK: IBOutlets
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Private Properties
    private let disposeBag = DisposeBag()
    private var historyTransactions = [HistoryTransaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        configureButton()
        configureTableView()
        presenter?.fetchHistoryTransactions()
    }
    
    // MARK: Stub Methods
    func populateTableView(_ data: [HistoryTransaction]) {
        DispatchQueue.main.async {
            self.historyTransactions = data
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        tableView.isHidden = true
        button.setTitle(message, for: .normal)
    }
    
    // MARK: Private Methods
    private func configureButton() {
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.presenter?.backToHomeScreen()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension HistoryTransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HistoryTransactionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let data = historyTransactions[indexPath.row]
        cell.textLabel?.text = "Paid \(data.fee.IDR) to \(data.merchant) at \(data.date.toTimeStamp)"
        cell.selectionStyle = .none
        
        return cell
    }
    
}
