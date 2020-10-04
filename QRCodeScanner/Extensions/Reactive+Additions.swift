//
//  Reactive+Additions.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 02/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension PublishSubject where Element == Bool {
    var toggle: Observable<Element> {
        map { !$0 }
    }
}

extension PublishSubject where Element == String {
    var convertToImage: Observable<UIImage?> {
        map { ImageValidator.image(for: $0) }
    }
}

extension Reactive where Base: UIActivityIndicatorView {
    public var isLoadingVisible: Binder<Bool> {
        return Binder(self.base) { activityIndicator, active in
            if active {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }

}
