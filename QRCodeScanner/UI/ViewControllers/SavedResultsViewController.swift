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
    @IBOutlet var tableView: UITableView!
    
    private let viewModel = SavedResultsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.images
            .bind(to: tableView.rx.items(cellIdentifier: "SavedResultsCell")) { (row, image, cell) in
            cell.textLabel?.text = image.name
            cell.detailTextLabel?.text = image.savedAt?.string(dateFormat: "dd.MM.yyyy")
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .subscribe(onNext: { self.viewModel.deleteImage(at: $0) })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                guard let image = try? self.viewModel.images.value()[indexPath.row] else {
                    return
                }
                
                let detailsViewModel = SavedImageDetailsViewModel(image: image)
                let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
                self.navigationController?.present(detailsViewController, animated: true)
            }).disposed(by: disposeBag)
        
        viewModel.fetchImages()
    }
    
    @IBAction func closeDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
