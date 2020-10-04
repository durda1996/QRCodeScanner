//
//  QRCodeScanner.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 04/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift

enum QRCodeScannerError: Error {
    case notSupported
    
    var title: String {
        switch self {
        case .notSupported:
            return "Scanning not supported"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .notSupported:
            return "Your device does not support scanning a code from an item. Please use a device with a camera."
        }
    }
}

class QRCodeScanner: NSObject {
    let foundText: PublishSubject<String> = PublishSubject()
    let error: PublishSubject<QRCodeScannerError> = PublishSubject()
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    func setup(on view: UIView, rectOfInterest: CGRect) {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            error.onNext(.notSupported)
            return
        }
        
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            self.error.onNext(.notSupported)
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            error.onNext(.notSupported)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: rectOfInterest)
        } else {
            error.onNext(.notSupported)
            return
        }

        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    func startScanning() {
        guard let captureSession = captureSession else {
            return
        }
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopScanning() {
        guard let captureSession = captureSession else {
            return
        }
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopSession() {
        captureSession = nil
        previewLayer = nil
    }
}

extension QRCodeScanner: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundText.onNext(stringValue)
        }
        
    }
}
