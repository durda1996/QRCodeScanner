//
//  DetailsViewController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 26/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: ActionSheetViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailsLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var bottomActionButton: UIButton!
    
    private let viewModel: DetailsViewModelProtocol
    private let disposeBag = DisposeBag()
    private let storageManager = StorageManager()
    private var imageLink = ""
    
    init(viewModel: DetailsViewModelProtocol) {
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
        titleLabel.text = viewModel.titleText
        detailsLabel.text = viewModel.detailsText
        bottomActionButton.setTitle(viewModel.bottomButtonAction.localizedString, for: .normal)
        
        viewModel.isLoading
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .toggle
            .bind(to: spinner.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .toggle
            .bind(to: bottomActionButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.imageLink
            .convertToImage
            .observeOn(MainScheduler.instance)
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.imageLink
            .bind { imageLink in
                self.imageLink = imageLink
        }.disposed(by: disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.instance)
            .bind { error in
                print(error)
                self.imageView.image = UIImage(named: "no-image")
        }.disposed(by: disposeBag)
        
        viewModel.performFetch()
    }
    
    @IBAction func bottomButtonDidTap(_ sender: UIButton) {
        switch viewModel.bottomButtonAction {
        case .save:
            do {
                try storageManager.saveImage(withName: viewModel.imageName, imageLink: imageLink)
                dismiss(animated: true)
            } catch {
                print(error)
                // TODO: - show popup
            }
        case .close:
            break
        }
    }
}
