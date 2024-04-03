//
//  ScanQRISViewController.swift
//  QRISApp
//
//  Created by Mohammad Azri on 01/04/24.
//

import UIKit
import AVFoundation

class ScanQRISViewController: UIViewController, ScanQRISView {
    
    // MARK: Stub Properties
    var presenter: ScanQRISPresenter?
    
    // MARK: Private Properties
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var isCaptured = false
    
    // MARK: IBOutlets
    @IBOutlet private weak var detailQRISStackView: UIStackView!
    @IBOutlet private weak var confirmPaymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.requestCameraAccess()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    // MARK: Stub Methods
    func showPermissionAlert() {
        let alert = UIAlertController(title: "Camera Access Denied", message: "Please grant access to the camera in Settings to continue.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { [weak self] _ in
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingURL)
                self?.createBackButton()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func configCamera() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            
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
            } catch {
                print("\(error.localizedDescription)")
            }
            
            
            DispatchQueue.main.async {
                self.createLivePreview(self.captureSession)
                self.createBackButton()
            }
            
            self.captureSession.startRunning()
        }
    }
    
    func stopPreviewing() {
        captureSession.stopRunning()
        previewLayer?.removeFromSuperlayer()
    }
    
    func showDetailTransaction(_ merchant: String, _ nominal: String, _ id: String) {
        
        detailQRISStackView.removeAllArrangedSubviews()
        detailQRISStackView.isHidden = false
        confirmPaymentButton.isHidden = false
        
        for i in 0...2 {
            detailQRISStackView.addArrangedSubview(createLabel(i == 0 ? merchant : i == 1 ? nominal : id))
        }
        view.stopLoading()
        view.layoutIfNeeded()
    }
    
    // MARK: Private Methods
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
        presenter?.backToHomeScreen()
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
    
    // MARK: IBActions
    @IBAction private func onConfirmPaymentButtonTapped(_ sender: UIButton) {
        presenter?.requestProcessPayment()
    }
}

extension ScanQRISViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard !isCaptured, let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else {
            return
        }
        isCaptured = true
        presenter?.processOutput(string: stringValue)
        stopPreviewing()
        view.addSubview(LoadingView(frame: view.bounds))
    }
}
