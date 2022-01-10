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
    let context = CoreDataManager.sharedManager.persistentContainer
    
    func createFoodItem(
        food_id: String,
        food_type_id: String,
        food_name: String,
        store_date: Date,
        expire_date: Date,
        food_qty: Int
    ){
        do{
          //  if let getType =
        }
    }
}
