//
//  GoogleImageResponse.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 22/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

struct ImageLoaderResponse: Decodable {
    let items: [Item]
}

extension ImageLoaderResponse {
    struct Item: Decodable {
        let link: String
        let image: Image
    }
}

extension ImageLoaderResponse.Item {
    struct Image: Decodable {
        let thumbnailLink: String
    }
}





