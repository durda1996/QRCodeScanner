//
//  NoSavedImagesView.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 04/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

class NoSavedImagesView: IBDesignableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTexts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTexts()
    }
}

private extension NoSavedImagesView {
    func setupTexts() {
        titleLabel.text = "No saved images"
        descriptionLabel.text = "Use scanner and save the image to see the list"
    }
}
