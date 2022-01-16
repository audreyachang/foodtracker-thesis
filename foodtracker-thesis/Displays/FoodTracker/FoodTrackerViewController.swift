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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if FoodCategoryRepository.shared.getAllFoodCategory()?.count == 0 {
            preloadFoodCategory()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
}

//MARK: Initial Setup
extension FoodTrackerViewController{
    func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = false
        foodRecommendLabel.text = "Food Item Recommendation"
        foodItemLabel.text = "Food Records"
        recommendCollectionView.register(UINib(nibName: "FoodItemRecommendationCell", bundle: nil), forCellWithReuseIdentifier: "FoodItemRecommendationCell")

        foodRecordTableView.register(UINib(nibName: "FoodRecordCell", bundle: nil), forCellReuseIdentifier: "FoodRecordCell")
    }
}

//MARK: Collection View Delegate
extension FoodTrackerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let foodRecommCell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "FoodItemRecommendationCell", for: indexPath)as! FoodItemRecommendationCell
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
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
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any){
    performSegue(withIdentifier: "goToForm", sender: self)
    }
    
    @IBAction func unwindToFoodList(_ unwindSegue: UIStoryboardSegue) {
        
    }
}
