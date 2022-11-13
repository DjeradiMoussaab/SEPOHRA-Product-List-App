//
//  PersistenceManager.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 28/10/2022.
//

import Foundation
import CoreData


struct PersistenceManager {
    
    static let shared = PersistenceManager()
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SEPOHRA_Product_List_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        PersistenceManager.shared.container.viewContext
    }
    
    func saveContext () {
        let context = PersistenceManager.shared.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
