//
//  CompostTypeRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation
import UIKit
import CoreData

class CompostTypeRepository{
    static let shared = CompostTypeRepository()
    let entityName = CompostType.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createCompostType(compost_type_id: Int,
                           compost_type_name: String){
        do{
            let compostType = CompostType(context: context)
            compostType.compostTypeId = Int32(compost_type_id)
            compostType.compostTypeName = compost_type_name
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func getCompostTypeById(compostTypeId: Int)-> CompostType? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "compostTypeId == '\(compostTypeId)'")
        do{
            let item = try context.fetch(fetchRequest)as? [CompostType]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    func getAllCompostType()-> [CompostType]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest)as? [CompostType]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
}


