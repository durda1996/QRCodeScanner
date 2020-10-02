//
//  DetailsViewModelProtocol.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation
import RxSwift

enum BottomButtonAction {
    case save
    case close
    
    var localizedString: String {
        switch self {
        case .save: return "Save"
        case .close: return "Close"
        }
    }
}

protocol DetailsViewModelProtocol {
    var titleText: String { get }
    var bottomButtonAction: BottomButtonAction { get }
    
    var imageLink: PublishSubject<String> { get }
    var isLoading: PublishSubject<Bool> { get }
    var error: PublishSubject<ImageLoaderError> { get }

    func performFetch()
}
