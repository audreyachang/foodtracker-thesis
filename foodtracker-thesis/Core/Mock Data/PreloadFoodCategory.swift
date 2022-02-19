//
//  PreloadFoodCategory.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit

func preloadFoodCategory(){
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 0, food_type_name: "Fruits", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 1, food_type_name: "Veggies", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 2, food_type_name: "Meat", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 3, food_type_name: "Seafood", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 4, food_type_name: "Drink", waste_type_id: 1)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 5, food_type_name: "Grains", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 6, food_type_name: "Poultry", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 7, food_type_name: "Dairy", waste_type_id: 1)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 8, food_type_name: "Beans & Nuts", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 9, food_type_name: "Snacks", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 10, food_type_name: "Desserts", waste_type_id: 1)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 11, food_type_name: "Leftovers", waste_type_id: 0)
    FoodCategoryRepository.shared.createFoodCategory(food_type_id: 12, food_type_name: "Others", waste_type_id: 1)
    
}
