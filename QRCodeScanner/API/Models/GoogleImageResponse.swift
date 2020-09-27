//
//  GoogleImageResponse.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 22/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

struct GoogleImageResponse: Decodable {
    let items: [GoogleImageItemResponse]
}

struct GoogleImageItemResponse: Decodable {
    let link: String
}


