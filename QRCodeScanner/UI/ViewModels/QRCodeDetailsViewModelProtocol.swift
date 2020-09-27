//
//  QRCodeDetailsViewModelProtocol.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

protocol QRCodeDetailsViewModelProtocol {
    typealias ImageCompletion = (UIImage) -> Void
    
    var titleText: String { get }
    var bottomButtonText: String { get }
    func image(completion: @escaping ImageCompletion)
}
