//
//  ScanQRISInteractor.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import Foundation
import AVFoundation

protocol ScanQRISInteractor: BaseInteractor { 
    func requestCameraAccess(completion: @escaping (Bool) -> Void)
    func requestProcessPayment(id: Int, completion: (Result<Payment, Error>) -> Void)
}

class ScanQRISInteractorImpl: ScanQRISInteractor {
    
    func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion(granted)
        }
    }
    
    func requestProcessPayment(id: Int, completion: (Result<Payment, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "payment", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let paymentResponse = try JSONDecoder().decode(PaymentResponse.self, from: data)
            print("paymentResponse: \(paymentResponse)")
            completion(.success(paymentResponse.toPayment))
        } catch {
            completion(.failure(error))
        }
    }
    
}
