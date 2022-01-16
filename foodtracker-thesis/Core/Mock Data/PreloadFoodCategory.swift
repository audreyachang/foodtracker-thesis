//
//  PreloadFoodCategory.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit

func preloadFoodCategory(){
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 0, food_type_name: "Fruits", waste_type: "Compostable")
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 1, food_type_name: "Veggies", waste_type: "Compostable")
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 2, food_type_name: "Meat", waste_type: "Compostable")
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 3, food_type_name: "Fish", waste_type: "Compostable")
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 4, food_type_name: "Grains", waste_type: "Compostable")
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 5, food_type_name: "Drinks", waste_type: "Non-compostable")
}
