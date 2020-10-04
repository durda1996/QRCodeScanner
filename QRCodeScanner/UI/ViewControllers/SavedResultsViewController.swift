//
//  SavedResultsViewController.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 02/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SavedResultsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var noSavedImagesView: NoSavedImagesView!
    
    var viewModel: SavedResultsViewModel?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            fatalError("viewModel not exist. Add this value in the coordinator.")
        }
        
        // show table view if saved images available
        viewModel.isImagesAvailable
            .toggle
            .bind(to: tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // show no saved images view if no pictures have been saved
        viewModel.isImagesAvailable
            .bind(to: noSavedImagesView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // cell configuration observer
        viewModel.images
            .bind(to: tableView.rx.items(cellIdentifier: "SavedResultsCell")) { (row, image, cell) in
            cell.textLabel?.text = image.name
            cell.detailTextLabel?.text = image.savedAt?.string(dateFormat: "dd.MM.yyyy")
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        // cell deletion observer
        tableView.rx.itemDeleted
            .subscribe(onNext: { viewModel.deleteImage(at: $0) })
            .disposed(by: disposeBag)
        
        // cell selection observer
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                guard let image = try? viewModel.images.value()[indexPath.row] else {
                    return
                }
                
                viewModel.showImages(forImage: image)
            }).disposed(by: disposeBag)
        
        // fetch saved images
        viewModel.fetchImages()
    }
    
    @IBAction func closeDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
