//
//  SavedImageDetailsViewModel.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 02/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation
import RxSwift

struct SavedImageDetailsViewModel {
    private let image: Image
    
    let imageLink: PublishSubject<String> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<ImageLoaderError> = PublishSubject()
    
    init(image: Image) {
        self.image = image
    }
}

extension SavedImageDetailsViewModel: DetailsViewModelProtocol {
    var titleText: String { image.name ?? "(No name available)" }
    var detailsText: String { image.link ?? "(No image link available)" }
    var imageName: String { titleText }
    var bottomButtonAction: BottomButtonAction { .close }
    
    func performFetch() {
        guard let link = image.link else {
            error.onNext(.noImageUrl)
            return
        }
        
        guard ImageValidator.isImageValid(for: link) else {
            error.onNext(.invalidImageUrl)
            return
        }
        
        imageLink.onNext(link)
    }
}
