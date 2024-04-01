//
//  ScanQRISViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit
import AVFoundation

class ScanQRISViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // MARK: Private Properties
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var isCaptured = false
    
    // MARK: IBOutlets
    @IBOutlet private weak var detailQRISStackView: UIStackView!
    @IBOutlet private weak var confirmPaymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindObservers()
        requestCameraAccess()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    // MARK: Private Methods
    private func bindObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func appDidBecomeActive() {
        requestCameraAccess()
    }
    
    private func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            if granted {
                self?.configureQRScanner()
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.presentPermissionAlert()
                }
            }
        }
    }
    
    private func presentPermissionAlert() {
        let alert = UIAlertController(title: "Camera Access Denied", message: "Please grant access to the camera in Settings to continue.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingURL)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func configureQRScanner() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.captureSession.beginConfiguration()
            
            do {
                guard let device = AVCaptureDevice.default(for: .video) else {
                    print("Can't access camera")
                    return
                }
                
                let input = try AVCaptureDeviceInput(device: device)
                self.captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                self.captureSession.addOutput(captureMetadataOutput)
                
                let supportedTypes = captureMetadataOutput.availableMetadataObjectTypes
                if supportedTypes.contains(where: { $0 == AVMetadataObject.ObjectType.qr }) {
                    captureMetadataOutput.metadataObjectTypes = [.qr]
                } else {
                    print("QRCode isn't supported")
                    return
                }
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                self.captureSession.commitConfiguration()
                
                DispatchQueue.main.async {
                    self.createLivePreview(self.captureSession)
                    self.createBackButton()
                }
                
                self.captureSession.startRunning()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func createLivePreview(_ captureSession: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        if let previewLayer {
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }
    }
    
    private func createBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 16, y: 60, width: 40, height: 40)
        view.addSubview(backButton)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showQRISDetailTransaction(_ value: String) {
        let valueComponents = value.components(separatedBy: ".")
        
        if valueComponents.count == 4 {
            detailQRISStackView.removeAllArrangedSubviews()
            detailQRISStackView.isHidden = false
            confirmPaymentButton.isHidden = false
            
            let merchant = "Merchant Name \(valueComponents[2])"
            let nominal = "Transaction Nominal \(valueComponents[3].IDR)"
            let id = "Transaction ID \(valueComponents[1].dropFirst(2))"
            
            for i in 0...2 {
                detailQRISStackView.addArrangedSubview(createLabel(i == 0 ? merchant : i == 1 ? nominal : id))
            }
            
            view.layoutIfNeeded()
        }
    }
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.text = text
        label.numberOfLines = 0
        
        return label
    }
    @IBAction func onConfirmPaymentButtonTapped(_ sender: UIButton) {
        print("Ini \(#function)")
    }
}

extension ScanQRISViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if !isCaptured, let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            isCaptured = true
            print(stringValue)
            captureSession.stopRunning()
            previewLayer?.removeFromSuperlayer()
            showQRISDetailTransaction(stringValue)
        }
    }
}
