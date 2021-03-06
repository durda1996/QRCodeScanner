//
//  CurrentDetailsViewModel.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation
import RxSwift

struct CurrentDetailsViewModel {
    private let imageLoader = ImageLoader()
    private let searchText: String
    
    let imageLink: PublishSubject<String> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let error: PublishSubject<ImageLoaderError> = PublishSubject()
    
    init(searchText: String) {
        self.searchText = searchText
    }
}

extension CurrentDetailsViewModel: DetailsViewModelProtocol {
    var titleText: String { "Found" }
    var detailsText: String { searchText.inQuotationMarks }
    var imageName: String { searchText }
    
    var bottomButtonAction: BottomButtonAction { .save }
    
    func performFetch() {
        isLoading.onNext(true)
        imageLoader.fetchImageLink(matching: imageName) { result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let imageLink):
                self.imageLink.onNext(imageLink)
            case .failure(let error):
                self.error.onNext(error)
            }
        }
    }
}
