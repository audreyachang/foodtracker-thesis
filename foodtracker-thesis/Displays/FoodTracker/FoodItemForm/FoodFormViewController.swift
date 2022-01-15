//
//  FoodFormViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class FoodFormViewController: UIViewController {

    @IBOutlet weak var foodNameView: LabelWithTextField!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryContentLabel: UILabel!
    @IBOutlet weak var measurementTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var estimationDateView: LabelWithDate!
    @IBOutlet weak var foodCategoryCollection: UICollectionView!
    @IBOutlet weak var addFoodRecordButton: UIButton!
    
    var category = [FoodType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if FoodCategoryRepository.shared.getAllFoodCategory()?.count == 0{
            preloadFoodCategory()
        }
        // Do any additional setup after loading the view.
    }
}

//MARK: Initial Setup
extension FoodFormViewController{
    func setup(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "New Food"
        foodCategoryCollection.register(UINib(nibName: "FoodCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FoodCategoryCollectionCell")
        foodCategoryCollection.delegate = self
        foodCategoryCollection.dataSource = self
        foodCategoryCollection.reloadData()
        foodNameView.textField.placeholder = "Enter Your Food Name"
        foodNameView.titleLabel.text = "Food Name"
        categoryTitleLabel.text = "Categories"
        categoryContentLabel.text = "Choose food category"
        amountLabel.text = "Amount"
        measurementTextField.placeholder = "pcs/kg"
        estimationDateView.titleLabel.text = "Estimated expiration date"
        estimationDateView.contentLabel.text = "Estimated expiry on"
        addFoodRecordButton.titleLabel?.text = "Add Item"
    }
}

//MARK: CollectionViewDelegate
extension FoodFormViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category = getAllCategory()
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCategoryCollection.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCollectionCell", for: indexPath)as! FoodCategoryCollectionCell
        cell.categoryName.text = category[indexPath.row].foodTypeName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = foodCategoryCollection.cellForItem(at: indexPath)as? FoodCategoryCollectionCell{
            cell.foodCategoryContentView.backgroundColor = .lightGray
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = foodCategoryCollection.cellForItem(at: indexPath)as? FoodCategoryCollectionCell{
            cell.foodCategoryContentView.backgroundColor = .white
        }
    }
}

//MARK: CoreData
extension FoodFormViewController{
    func getInitialData(){
    }
    
    func getAllCategory()->[FoodType]{
        guard let data = FoodCategoryRepository.shared.getAllFoodCategory() else{
            return [FoodType]()
        }
        return data
    }
    
    func saveData(foodId: String, foodName: String, foodQty: Int, expDate: Date, storeDate: Date, foodTypeId: Int)-> Bool{
        let newData = FoodDataRepository.shared.createFoodItem(food_id: UUID().uuidString, food_type_id: foodTypeId, food_name: foodName, store_date: Date(), expire_date: expDate, food_qty: foodQty)
        return newData
    }
}

