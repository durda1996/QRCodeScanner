//
//  ImageStorageManager.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 27/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

struct StorageManager: ContextProtocol {
    func saveImage(withName name: String, imageLink: String, at date: Date = Date()) throws {
        let image = Image(context: context)
        image.name = name
        image.link = imageLink
        image.savedAt = date
        
        try saveChanges()
    }
    
    func deleteImage(_ image: Image) throws {
        context.delete(image)
        
        try saveChanges()
    }
}

