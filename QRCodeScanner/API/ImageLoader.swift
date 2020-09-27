//
//  ImageLoader.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 21/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import UIKit

class ImageLoader {
    typealias Completion = (Result<UIImage, ImageLoaderError>) -> Void
    
    private let urlSession: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        urlSession = URLSession(configuration: configuration)
    }
    
    func fetchImage(matching query: String, completion: @escaping Completion) {
        guard let url = fetchImageUrl(for: query) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(.networkError(cause: error)))
                } else {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            self.handle(data: data, completion: completion)
        }
        
        dataTask.resume()
    }
}

private extension ImageLoader {
    func fetchImageUrl(for query: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.googleapis.com"
        urlComponents.path = "/customsearch/v1"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "AIzaSyDR1DycAZhBJLry4WQn4c4oVDI-DMxJzpU"),
            URLQueryItem(name: "cx", value: "b53036b18df82fa6c"),
            URLQueryItem(name: "num", value: "1"),
            URLQueryItem(name: "imgSize", value: "medium"),
            URLQueryItem(name: "searchType", value: "image"),
            URLQueryItem(name: "filetype", value: "jpg"),
            URLQueryItem(name: "q", value: query)
        ]
        
        return urlComponents.url
    }
    
    func handle(data: Data, completion: Completion) {
        do {
            let result = try JSONDecoder().decode(GoogleImageResponse.self, from: data)
            
            guard let googleImageItem = result.items.first else {
                completion(.failure(.noImagesFound))
                return
            }
            
            guard let url = URL(string: googleImageItem.link),
                let urlData = try? Data(contentsOf: url),
                let image = UIImage(data: urlData) else {
                completion(.failure(.incorrectImageUrl))
                return
            }
            
            completion(.success(image))
        } catch {
            completion(.failure(.decodingError(cause: error)))
        }
    }
}


