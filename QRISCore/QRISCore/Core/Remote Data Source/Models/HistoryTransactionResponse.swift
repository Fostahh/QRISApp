//
//  HistoryTransactionResponse.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation

public struct HistoryTransactionResponseRoot: Codable {
    public let data: HistoryTransactionResponseRecords
}

public struct HistoryTransactionResponseRecords: Codable {
    public let records: [HistoryTransactionResponse]
}

public struct HistoryTransactionResponse: Codable {
    let id: Int
    let fee, date: Double
    let merchant: String
    
    enum CodingKeys: String, CodingKey {
        case id = "transaction_id"
        case fee, date, merchant
    }
}

public extension HistoryTransactionResponse {
    static func toDomain(response: [HistoryTransactionResponse]) -> [HistoryTransaction] {
        response.compactMap({ HistoryTransaction(id: $0.id, fee: $0.fee, date: $0.date, merchant: $0.merchant) })
    }
}
