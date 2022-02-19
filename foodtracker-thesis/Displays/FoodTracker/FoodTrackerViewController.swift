//
//  FoodTrackerViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 03/01/22.
//

import UIKit

class FoodTrackerViewController: UIViewController {

    @IBOutlet weak var foodItemLabel: UILabel!
    @IBOutlet weak var foodRecommendLabel: UILabel!
    @IBOutlet weak var notifButton: UIButton!
    @IBOutlet weak var recommendCollectionView: UICollectionView! 
    @IBOutlet weak var addNewItemButton: UIButton!
    @IBOutlet weak var foodRecordTableView: UITableView!
    
    var category = [FoodType]()
    var foodData = [FoodData]()
    var recommendFood = [FoodData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if FoodCategoryRepository.shared.getAllFoodCategory()?.count == 0 {
            preloadFoodCategory()
        }
        getAllData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setup()
        getAllData()
        foodRecordTableView.reloadData()
        recommendCollectionView.reloadData()
    }
}

//MARK: Initial Setup
extension FoodTrackerViewController{
    func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.backButtonTitle = ""
        foodRecommendLabel.text = "Expired Soon"
        foodItemLabel.text = "Food List"
        recommendCollectionView.register(UINib(nibName: "FoodItemRecommendationCell", bundle: nil), forCellWithReuseIdentifier: "FoodItemRecommendationCell")

        foodRecordTableView.register(UINib(nibName: "FoodRecordCell", bundle: nil), forCellReuseIdentifier: "FoodRecordCell")
        recommendFood = [FoodData]()
        for i in 0..<foodData.count{
            if foodData[i].expireDate ?? Date() < Date() && !recommendFood.contains(foodData[i]) {
                recommendFood.append(foodData[i])
                print(recommendFood)
            }
        }
        recommendCollectionView.reloadData()
    }
}

//MARK: Collection View Delegate
extension FoodTrackerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let foodRecommCell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemRecommendationCell", for: indexPath)as! FoodItemRecommendationCell
        foodRecommCell.foodItemLabel.text = recommendFood[indexPath.row].foodName
        foodRecommCell.foodQtyLabel.text = "\(recommendFood[indexPath.row].foodQuantity) \(recommendFood[indexPath.row].measurementType ?? "")"
        foodRecommCell.expirationDateLabel.text = "Exp " + String(recommendFood[indexPath.row].expireDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
            return foodRecommCell
              
    }
    
    
}

//MARK: Table View Delegate
extension FoodTrackerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodRecordTableView.dequeueReusableCell(withIdentifier: "FoodRecordCell", for: indexPath)as! FoodRecordCell
        cell.foodItemName.text = foodData[indexPath.row].foodName
        cell.foodItemQty.text = String(foodData[indexPath.row].foodQuantity)
        cell.foodItemQty.text! += " " + foodData[indexPath.row].measurementType!
        let foodType = FoodCategoryRepository.shared.getFoodCategoryById(id: Int(foodData[indexPath.row].foodTypeId))
        cell.foodItemCategory.text = foodType?.foodTypeName
        cell.expirationDate.text = "Exp Date: " + String(foodData[indexPath.row].expireDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard  = UIStoryboard(name: "FoodForm", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "goToFoodForm")as! FoodFormViewController
        vc.dataFrom = "Edit"
        vc.currentFoodId = foodData[indexPath.row].foodId!
        vc.currentCategory = Int(foodData[indexPath.row].foodTypeId)
        print(foodData[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        }
}

//MARK: Core Data
extension FoodTrackerViewController{
    func getAllData(){
        category = getAllCategory()
        foodData = getAllFoodData()
    }
    
    func getAllCategory()->[FoodType]{
        guard let data = FoodCategoryRepository.shared.getAllFoodCategory() else{
            return [FoodType]()
        }
        return data
    }
    
    func getAllFoodData()->[FoodData]{
        guard let data = FoodDataRepository.shared.getAllFoodItem() else{
            return [FoodData]()
        }
        return data
    }
}

//MARK: Segue
extension FoodTrackerViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToForm"{
            let vc = segue.destination as? FoodFormViewController
            vc?.dataFrom = "Add"
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any){
    performSegue(withIdentifier: "goToForm", sender: self)
    }
    
    @IBAction func unwindToFoodList(_ unwindSegue: UIStoryboardSegue) {
        
    }
}
