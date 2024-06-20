//
//  Payment.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

struct Payment {
    let id: Int
    let fee: Double
    let paymentStatus: PaymentStatus
    
    init(id: Int, fee: Double, paymentStatus: PaymentStatus) {
        self.id = id
        self.fee = fee
        self.paymentStatus = paymentStatus
    }
}

extension Payment {
    enum PaymentStatus {
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
