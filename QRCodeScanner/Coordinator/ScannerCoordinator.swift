//
//  AppCoordinator.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 03/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

protocol ScannerCoordinatorProtocol {
    func showSavedResults()
    func showCurrentDetails(forScannedText scannedText: String, scanner: QRCodeScanner)
}

class ScannerCoordinator: BaseCoordinator {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    override func start() {
        let storyboard = UIStoryboard(name: "Scanner", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        let viewController = navigationController.topViewController as! ScannerViewController
        let viewModel = ScannerViewModel(coordinator: self)
        viewController.viewModel = viewModel
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.navigationController = navigationController
    }
}

extension ScannerCoordinator: ScannerCoordinatorProtocol {
    func showSavedResults() {
        let coordinator = SavedImagesCoordinator(navigationController: navigationController)
        start(coordinator: coordinator)
    }
    
    func showCurrentDetails(forScannedText scannedText: String, scanner: QRCodeScanner) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, scannedText: scannedText, scanner: scanner)
        start(coordinator: detailsCoordinator)
    }
}
