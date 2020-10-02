//
//  PublishSubject+Additions.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 02/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit
import RxSwift

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
