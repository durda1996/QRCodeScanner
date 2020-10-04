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
    
    let didDismiss = BehaviorSubject(value: false)
    
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
        
        // show and animate spinner when image is loading
        viewModel.isLoading
            .bind(to: spinner.rx.isLoadingVisible)
            .disposed(by: disposeBag)
        
        // disable bottom button when image is loading
        viewModel.isLoading
            .toggle
            .bind(to: bottomActionButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // show image asynchronously
        viewModel.imageLink
            .convertToImage
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        // set private imageLink variable when image did load
        viewModel.imageLink
            .bind { imageLink in
                self.imageLink = imageLink
        }.disposed(by: disposeBag)
        
        // show no image icon when image loading failed
        viewModel.error
            .observeOn(MainScheduler.asyncInstance)
            .bind { error in
                print(error)
                self.imageView.image = UIImage(named: "no-image")
        }.disposed(by: disposeBag)
        
        // fetch image
        viewModel.performFetch()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        didDismiss.onNext(true)
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
            dismiss(animated: true)
        }
    }
}
