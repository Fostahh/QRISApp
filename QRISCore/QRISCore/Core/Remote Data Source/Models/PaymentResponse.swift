//
//  PaymentResponse.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

public struct PaymentResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "transaction_id"
        case paymentStatusRaw = "payment_status"
        case fee
    }
    
    let id: Int
    let paymentStatusRaw: Int
    let fee: Double
}

public extension PaymentResponse {
    var toDomain: Payment {
        Payment(
            id: id,
            fee: fee,
            paymentStatus: Payment.PaymentStatus(rawValue: paymentStatusRaw)
        )
    }
}
