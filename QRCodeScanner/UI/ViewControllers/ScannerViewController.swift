//
//  ScannerViewController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import RxSwift

class ScannerViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: ScannerViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            fatalError("viewModel not exist. Add this value in the coordinator.")
        }

        view.backgroundColor = UIColor.black
        
        let scannerCaptureView = createScannerCaptureView(width: 200, height: 200)
        
        // show details screen when qr code scanned successfully
        viewModel.scanner.foundText
            .bind { scannedText in
                self.viewModel?.currentDetailsDidFind(scannedText: scannedText)
            }.disposed(by: disposeBag)
        
        // show alert when qr code scanning failed
        viewModel.scanner.error
            .bind { error in
                let alertController = UIAlertController(title: error.title, message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
                self.viewModel?.scanner.stopSession()
            }.disposed(by: disposeBag)
        
        // setup scanner with capture frame
        viewModel.scanner.setup(on: view, rectOfInterest: scannerCaptureView.frame)
        view.addSubview(scannerCaptureView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTransparentNavigationBar(true)
        viewModel?.scanner.startScanning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setTransparentNavigationBar(false)
        viewModel?.scanner.stopScanning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func showSavedResults(_ sender: UIBarButtonItem) {
        viewModel?.savedResultsDidTap()
    }
}

private extension ScannerViewController {
    func createScannerCaptureView(width: CGFloat, height: CGFloat) -> UIView {
        let frame = CGRect(
            x: (view.frame.width / 2) - (width / 2),
            y: (view.frame.height / 2) - (height / 2),
            width: width,
            height: height
        )
        
        let captureView = UIView(frame: frame)
        captureView.backgroundColor = .clear
        
        let drawer = ScannerFrameDrawer()
        drawer.draw(on: captureView)
        
        return captureView
    }
}
