//
//  CompostDetailRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit
import CoreData

class CompostDetailRepository{
    static let shared = CompostDetailRepository()
    let entityName = CompostDetail.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createCompostDetail(compost_id: String, food_type_id: Int, ingredient_name: String){
        do{
            let compostDetail = CompostDetail(context: context)
            compostDetail.ingredientName = ingredient_name
            
            if let compostDetails = CompostDataRepository.shared.getCompostDataById(compost_id: compost_id){
                compostDetail.compostId = compostDetails.compostId
            }
            if let compostTypes = FoodCategoryRepository.shared.getFoodCategoryById(id: food_type_id){
                compostDetail.foodTypeId = compostTypes.foodTypeId
            }
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func getAllCompostDetail()->[CompostDetail]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest)as? [CompostDetail]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    func getCompostDetailById(compost_id: String)-> CompostDetail?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "compostId == '\(compost_id)'")
        do{
            let item = try context.fetch(fetchRequest)as? [CompostDetail]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    func deleteCompostData(data: CompostDetail)->Bool{
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
