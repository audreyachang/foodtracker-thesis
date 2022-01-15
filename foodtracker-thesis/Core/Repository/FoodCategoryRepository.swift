//
//  FoodCategoryRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit
import CoreData

class FoodCategoryRepository{
    static let shared = FoodCategoryRepository()
    let entityName = FoodType.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createFoodCategory(
        food_type_id: Int,
        food_type_name: String,
        waste_type: String
    ){
        do{
            let foodCategory = FoodType(context: context)
            foodCategory.foodTypeId = Int32(food_type_id)
            foodCategory.foodTypeName = food_type_name
            foodCategory.wasteType = waste_type
          try context.save()
            
        }
        catch let error as NSError{
            print(error)
        }
    }

    func getAllFoodCategory()->[FoodType]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest) as? [FoodType]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    func getFoodCategoryById(id: Int)-> FoodType?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "foodTypeId == %d", id as CVarArg)
        do{
            let item = try context.fetch(fetchRequest)as? [FoodType]
            return item?.first
        } catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    func updateFoodCategory(id: Int, newName: String, newWasteType: String){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "foodTypeId == %d", id as CVarArg)
        do{
            let item = try context.fetch(fetchRequest) as? [FoodType]
            let foodType = item?.first
            foodType?.foodTypeName = newName
            foodType?.wasteType = newWasteType
            
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func deleteFoodType(data: FoodType){
        do{
            context.delete(data)
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
}
