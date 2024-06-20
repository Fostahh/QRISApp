//
//  HistoryTransactionResponse.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

struct HistoryTransactionResponseRoot: Codable {
    let data: HistoryTransactionResponseRecords
}

struct HistoryTransactionResponseRecords: Codable {
    let records: [HistoryTransactionResponse]
}

struct HistoryTransactionResponse: Codable {
    let id: Int
    let fee, date: Double
    let merchant: String
    
    enum CodingKeys: String, CodingKey {
        case id = "transaction_id"
        case fee, date, merchant
    }
}

extension HistoryTransactionResponse {
    static func toDomain(response: [HistoryTransactionResponse]) -> [HistoryTransaction] {
        response.compactMap({ HistoryTransaction(id: $0.id, fee: $0.fee, date: $0.date, merchant: $0.merchant) })
    }
}
