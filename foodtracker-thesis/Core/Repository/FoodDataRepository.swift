//
//  FoodDataRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit
import CoreData

class FoodDataRepository{
    static let shared =  FoodDataRepository()
    let entityName = FoodData.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createFoodItem(
        food_id: String,
        food_type_id: Int,
        food_name: String,
        store_date: Date,
        expire_date: Date,
        food_qty: Int,
        measurement_type: String
    )-> Bool{
        do{
          let foodData = FoodData(context: context)
            foodData.foodId = food_id
            foodData.foodTypeId = Int32(food_type_id)
            foodData.foodName = food_name
            foodData.storeDate = store_date
            foodData.expireDate = expire_date
            foodData.foodQuantity = Int32(food_qty)
            foodData.measurementType = measurement_type
            
            if let foodItems = FoodCategoryRepository.shared.getFoodCategoryById(id: food_type_id){
                foodData.foodTypeId = foodItems.foodTypeId
            }
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    func getAllFoodItem() -> [FoodData]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest) as? [FoodData]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    func getFoodItemById(id: String) -> FoodData?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "foodId == '\(id)'")
        do{
            let item = try context.fetch(fetchRequest) as? [FoodData]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    func updateFoodItem(food_id: String,
                        food_type_id: Int,
                        newFoodName: String,
                        store_date: Date,
                        expire_date: Date,
                        newFoodQty: Int)->Bool{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "foodId = '\(food_id)'")
        do{
            let item = try context.fetch(fetchRequest) as? [FoodData]
            let newFoodItem = item?.first
            newFoodItem?.foodTypeId = Int32(food_type_id)
            newFoodItem?.foodName = newFoodName
            newFoodItem?.foodQuantity = Int32(newFoodQty)
            newFoodItem?.expireDate = expire_date
            newFoodItem?.storeDate = store_date
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    func deleteFoodItem(data: FoodData)->Bool{
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
