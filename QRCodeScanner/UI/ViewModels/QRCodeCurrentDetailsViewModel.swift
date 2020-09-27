//
//  QRCodeResultViewModel.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

struct QRCodeCurrentDetailsViewModel {
    private let imageLoader = ImageLoader()
    private let searchText: String
    
    init(searchText: String) {
        self.searchText = searchText
    }
}

extension QRCodeCurrentDetailsViewModel: QRCodeDetailsViewModelProtocol {
    var titleText: String {
        "\"\(searchText)\""
    }
    
    var bottomButtonText: String {
        "Save"
    }
    
    func image(completion: @escaping ImageCompletion) {
        imageLoader.fetchImage(matching: titleText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(UIImage(named: "no-image")!)
                }
            }
        }
    }
    
}
