//
//  UIViewController+Additions.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

extension UIViewController {
    func setTransparentNavigationBar(_ transparent: Bool) {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationBar.setBackgroundImage(transparent ? UIImage() : nil, for: .default)
        navigationBar.shadowImage = transparent ? UIImage() : nil
        navigationBar.isTranslucent = transparent
    }
}
