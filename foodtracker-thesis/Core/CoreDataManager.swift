//
//  CoreDataManager.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 20/12/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let sharedManager = CoreDataManager(container: CoreDataManager.appScopeContainer())
    
    var persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer){
        self.persistentContainer = container
    }
    
    func setContainer(container: NSPersistentContainer){
        self.persistentContainer = container
    }
    
    static func appScopeContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: Constants.dataModel)
        container.loadPersistentStores(completionHandler: {(_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }
    
    func saveContext() {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllData() {
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        let storeDescription = persistentContainer.persistentStoreDescriptions[0]
        
        guard let storeURL = storeDescription.url else{
            return
        }
        
        do{
            try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        }catch{
            return
        }
        
        storeCoordinator.addPersistentStore(with: storeDescription) {
            (_, error) in
            
            if let error = error{
                print("\(error)")
            }
        }
        preloadData()
    }
    
}

extension CoreDataManager{
    func resetData(){
        CoreDataManager.sharedManager.deleteAllData()
        preloadData()
    }
    
    func preloadData(){
        if FoodCategoryRepository.shared.getAllFoodCategory()?.count == 0 {
            preloadFoodCategory()
            print("Preloading food category")
        }
    }
}
