//
//  CoreDataManager.swift
//  Remember2Remember
//
//  Created by Chris Boshoff on 2022/05/10.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let functions = CoreDataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Remember2Remember")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Failed to load \(error)")
            }
        }
        return container
    }()
    
    func createItem(title: String, expDate: String, remindDate: String) -> Item? {
        let context = persistentContainer.viewContext
        let note = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
        
        note.title = title
        note.expDate = expDate
        note.remindDate = remindDate
        
        do {
            try context.save()
        } catch {
            print("Failed to save Item")
        }
        return nil
    }
    
    func fetchItem() -> [Item]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        
        do {
            let items = try context.fetch(fetchRequest)
            return items
        } catch {
            print("Error fetching Items")
        }
        return nil
    }
    
    func updateItem(title: String, expDate: String, remindDate: String, itemObject: Item) {
        let context = persistentContainer.viewContext
        
        do {
            itemObject.title = title
            itemObject.expDate = expDate
            itemObject.remindDate = remindDate
            try context.save()
        } catch {
            print("Failed to update Item")
        }
    }
    
    func deleteItem(itemObject: Item) {
        let context = persistentContainer.viewContext
        context.delete(itemObject)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete Item")
        }
    }
}

