//
//  HistoryTransactionsView.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

protocol HistoryTransactionsView: BaseView {
    var presenter: HistoryTransactionsPresenter? { get set }
    
    func populateTableView(_ data: [HistoryTransaction])
    func showError(_ message: String)
}
