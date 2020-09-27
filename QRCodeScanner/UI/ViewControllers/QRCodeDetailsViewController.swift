//
//  QRCodeDetailsViewController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 26/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

class QRCodeDetailsViewController: ActionSheetViewController {
    @IBOutlet private var searchTextLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var bottomActionButton: UIButton!
    
    private let viewModel: QRCodeDetailsViewModelProtocol
    
    init(viewModel: QRCodeDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var contentSize: CGSize {
        CGSize(width: view.frame.width, height: 300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomActionButton.layer.cornerRadius = 10.0
        searchTextLabel.text = viewModel.titleText
        bottomActionButton.setTitle(viewModel.bottomButtonText, for: .normal)
        
        startLoading()
        viewModel.image { image in
            self.imageView.image = image
            self.stopLoading()
        }
    }
}

private extension QRCodeDetailsViewController {
    func startLoading() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopLoading() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}
