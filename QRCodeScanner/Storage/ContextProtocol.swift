//
//  ContextProtocol.swift
//  QRCodeScanner
//
//  Created by Dmytro Durda on 28/09/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import CoreData
import UIKit

protocol ContextProtocol {
    var context: NSManagedObjectContext { get }
    func saveChanges() throws
}

extension ContextProtocol {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveChanges() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
