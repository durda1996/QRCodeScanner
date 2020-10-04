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
    private let scanner = QRCodeScanner()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        scanner.foundText
            .bind { scannedText in
                let viewModel = CurrentDetailsViewModel(searchText: scannedText)
                let viewController = DetailsViewController(viewModel: viewModel)
                
                viewController.didDismiss
                    .bind { isDismissed in
                        if isDismissed {
                            self.scanner.startScanning()
                        }
                    }.disposed(by: self.disposeBag)
                
                self.navigationController?.present(viewController, animated: true)
            }.disposed(by: disposeBag)
        
        scanner.error
            .bind { error in
                let alertController = UIAlertController(title: error.title, message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
                self.scanner.stopSession()
            }.disposed(by: disposeBag)
        
        scanner.setup(for: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTransparentNavigationBar(true)
        scanner.startScanning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setTransparentNavigationBar(false)
        scanner.stopScanning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func showSavedResults(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "SavedResults", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller, animated: true)
    }
}
