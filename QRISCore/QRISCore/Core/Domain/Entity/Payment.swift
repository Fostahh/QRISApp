//
//  Payment.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

public struct Payment {
    public let id: Int
    public let fee: Double
    public let paymentStatus: PaymentStatus
    
    public init(id: Int, fee: Double, paymentStatus: PaymentStatus) {
        self.id = id
        self.fee = fee
        self.paymentStatus = paymentStatus
    }
}

extension Payment {
    public enum PaymentStatus {
        case success
        case failed
        
        init(rawValue: Int) {
            switch rawValue {
            case 1:
                self = .success
                
            default:
                self = .failed
            }
        }
    }
}
