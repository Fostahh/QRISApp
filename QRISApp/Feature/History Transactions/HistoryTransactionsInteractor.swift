//
//  HistoryTransactionsInteractor.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation
import QRISCore

protocol HistoryTransactionsInteractor: BaseInteractor {
    func getHistoryTransactions(completion: (Result<[HistoryTransaction], Error>) -> Void)
}

class HistoryTransactionsInteractorImpl: HistoryTransactionsInteractor {
    func getHistoryTransactions(completion: (Result<[HistoryTransaction], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "history_transactions", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let historyTransactionsResponseRoot = try JSONDecoder().decode(HistoryTransactionResponseRoot.self, from: data)
            let historyTransactionsResponse = historyTransactionsResponseRoot.data.records
            completion(.success(HistoryTransactionResponse.toDomain(response: historyTransactionsResponse)))
        } catch {
            completion(.failure(error))
        }
    }
    
}
