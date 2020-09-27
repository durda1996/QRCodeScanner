//
//  ImageValidator.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

struct ImageValidator {
    static func image(for link: String) -> UIImage? {
        guard let url = URL(string: link),
            let urlData = try? Data(contentsOf: url),
            let image = UIImage(data: urlData) else {
            return nil
        }
        
        return image
    }
    
    static func isImageValid(for link: String) -> Bool {
        image(for: link) != nil
    }
}
