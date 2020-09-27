//
//  QRCodeScannerViewController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

class QRCodeScannerViewController: UIViewController {
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var searchButton: UIButton!
    @IBOutlet private var imageVIew: UIImageView!
    
    private let imageLoader = ImageLoader()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTransparentNavigationBar(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setTransparentNavigationBar(false)
    }

    @IBAction func searchImage(_ sender: UIButton) {
        let searchText = searchTextField.text ?? ""
        let viewModel = QRCodeCurrentDetailsViewModel(searchText: searchText)
        let viewController = QRCodeDetailsViewController(viewModel: viewModel)
        navigationController?.present(viewController, animated: true)
    }
    
}

