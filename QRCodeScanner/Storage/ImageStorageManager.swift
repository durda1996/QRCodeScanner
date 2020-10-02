//
//  ImageStorageManager.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

struct ImageStorageManager: ContextProtocol {
    func saveImage(withName name: String, link: String, at date: Date = Date()) throws {
        let image = Image(context: context)
        image.name = name
        image.link = link
        image.savedAt = date
        
        try saveChanges()
    }
}

