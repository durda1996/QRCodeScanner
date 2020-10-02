//
//  SavedResultsViewModel.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 02/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class SavedResultsViewModel {
    let images = BehaviorSubject(value: [Image]())
    
    private let storageManager = StorageManager()
    private lazy var fetchedResultsController: NSFetchedResultsController<Image> = {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Image.savedAt), ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: storageManager.context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
    
    func fetchImages() {
        do {
            try fetchedResultsController.performFetch()
            
            if let savedImages = fetchedResultsController.fetchedObjects {
                images.onNext(savedImages)
            }
        } catch {
            fatalError("Failed to perform fetch: \(error)")
        }
    }
    
    func deleteImage(at indexPath: IndexPath) {
        do {
            var fetchedImages = try images.value()
            let image = fetchedImages[indexPath.row]
            
            fetchedImages.remove(at: indexPath.row)
            try storageManager.deleteImage(image)
            
            images.onNext(fetchedImages)
        } catch {
            print(error)
        }
    }
}
