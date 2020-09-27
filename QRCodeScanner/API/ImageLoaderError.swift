//
//  ImageLoaderError.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 23/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

enum ImageLoaderError: Error {
    case invalidURL
    case noImagesFound
    case incorrectImageUrl
    case decodingError(cause: Error)
    case networkError(cause: Error)
    case unknownError
    
    var localizedDescription: String {
        let result: String
        switch self {
        case .invalidURL:
            result = "Invalid URL"
        case .noImagesFound:
            result = "No images found"
        case .incorrectImageUrl:
            result = "Incorrect image URL"
        case .decodingError(let cause):
            result = "Decoding error - \(cause.localizedDescription)"
        case .networkError(let cause):
            result = "Network error - \(cause.localizedDescription)"
        case .unknownError:
            result = "Unknown error"
        }
        
        return "\(ImageLoaderError.self): \(result)"
    }
}