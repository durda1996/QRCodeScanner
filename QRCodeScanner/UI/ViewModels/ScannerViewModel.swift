//
//  ScannerViewModel.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 03/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

struct ScannerViewModel {
    let scanner = QRCodeScanner()
    
    private let coordinator: ScannerCoordinatorProtocol
    
    init(coordinator: ScannerCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func savedResultsDidTap() {
        coordinator.showSavedResults()
    }
    
    func currentDetailsDidFind(scannedText: String) {
        coordinator.showCurrentDetails(forScannedText: scannedText, scanner: scanner)
    }
}
