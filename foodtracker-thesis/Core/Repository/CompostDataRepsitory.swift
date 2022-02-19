//
//  CompostDataRepsitory.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit
import CoreData

class CompostDataRepository{
    static let shared = CompostDataRepository()
    let entityName = CompostData.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createCompostData(compost_id: String, start_date: Date, completion_date: Date)->Bool{
        do{
            let compostData = CompostData(context: context)
            compostData.compostId = compost_id
            compostData.startDate = start_date
            compostData.completionDate = completion_date
            
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    func getAllCompostData()->[CompostData]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest)as? [CompostData]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    func getCompostDataById(compost_id: String)->CompostData?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "compostId = '\(compost_id)'")
        do{
            let item = try context.fetch(fetchRequest) as? [CompostData]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    func deleteCompostData(data: CompostData) -> Bool{
        do{
            context.delete(data)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
}
