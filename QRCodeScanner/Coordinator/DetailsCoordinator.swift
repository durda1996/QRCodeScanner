//
//  DetailsCoordinator.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 04/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import RxSwift

class DetailsCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let scannedText: String
    private let scanner: QRCodeScanner
    
    init(navigationController: UINavigationController, scannedText: String, scanner: QRCodeScanner) {
        self.scannedText = scannedText
        self.scanner = scanner
        super.init()
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = CurrentDetailsViewModel(searchText: scannedText)
        let viewController = DetailsViewController(viewModel: viewModel)
        
        viewController.didDismiss
            .bind { isDismissed in
                if isDismissed {
                    self.scanner.startScanning()
                }
            }.disposed(by: self.disposeBag)
        
        navigationController.present(viewController, animated: true)
    }
}
