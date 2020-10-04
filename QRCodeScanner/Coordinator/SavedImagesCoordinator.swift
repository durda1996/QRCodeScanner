//
//  SavedImagesCoordinator.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 03/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

protocol SavedImagesCoordinatorProtocol: AnyObject {
    func showDetails(forImage image: Image)
}

class SavedImagesCoordinator: BaseCoordinator {
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    override func start() {
        let storyboard = UIStoryboard(name: "SavedResults", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        
        let viewController = controller.topViewController as! SavedResultsViewController
        let viewModel = SavedResultsViewModel(coordinator: self)
        viewController.viewModel = viewModel
        
        navigationController.present(controller, animated: true)
        
        self.navigationController = controller
    }
}

extension SavedImagesCoordinator: SavedImagesCoordinatorProtocol {
    func showDetails(forImage image: Image) {
        let detailsViewModel = SavedImageDetailsViewModel(image: image)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        navigationController.present(detailsViewController, animated: true)
    }
}
