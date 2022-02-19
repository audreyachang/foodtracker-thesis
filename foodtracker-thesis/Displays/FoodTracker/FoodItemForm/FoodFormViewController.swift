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
    
    @IBAction func addOrDeleteAction(_ sender: UIButton) {
        addOrDelete()
    }
    
    var category = [FoodType]()
    var dataFrom = ""
    var selectedCategory = Int()
    var currentCategory = 0
    var currentFoodId = ""
    var currentFoodData = FoodData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if FoodCategoryRepository.shared.getAllFoodCategory()?.count == 0{
            preloadFoodCategory()
        }
        selectedCategory = currentCategory
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        foodCategoryCollection.selectItem(at: IndexPath(row: currentCategory, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//        foodCategoryCollection.reloadData()
//    }
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView(foodCategoryCollection, didSelectItemAt: IndexPath(row: currentCategory, section: 0))
    }
}

//MARK: Initial Setup
extension FoodFormViewController{
    func setup(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "New Food"
        foodCategoryCollection.register(UINib(nibName: "FoodCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FoodCategoryCollectionCell")
        foodNameView.titleLabel.text = "Food Name"
        categoryTitleLabel.text = "Categories"
        categoryContentLabel.text = "Choose food category"
        estimationDateView.contentLabel.text = "Estimated Expiration Date"
        amountLabel.text = "Amount"
        foodCategoryCollection.delegate = self
        foodCategoryCollection.dataSource = self
        foodCategoryCollection.reloadData()
        if dataFrom == "Add"{
        foodNameView.textField.placeholder = "Enter Your Food Name"
        measurementTextField.placeholder = "pcs/kg"
        addFoodRecordButton.titleLabel?.text = "Add Item"
        }else{
            self.title = ""
            self.navigationController?.navigationBar.tintColor = .orangeTint
            currentFoodData = FoodDataRepository.shared.getFoodItemById(id: currentFoodId) ?? FoodData()
            foodNameView.textField.text = currentFoodData.foodName
            quantityTextField.text = String(currentFoodData.foodQuantity)
            currentCategory = Int(currentFoodData.foodTypeId)
            measurementTextField.text = currentFoodData.measurementType
            estimationDateView.datePicker.date = currentFoodData.expireDate!
            addFoodRecordButton.titleLabel?.text = "Delete Item"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(self.updateData(sender:)))
            
        }
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
        if let currentActive = foodCategoryCollection.cellForItem(at: IndexPath(row: currentCategory, section: 0))as? FoodCategoryCollectionCell{
            currentActive.foodCategoryContentView.backgroundColor = .clear        }

            if let cell = foodCategoryCollection.cellForItem(at: indexPath)as? FoodCategoryCollectionCell{
                cell.foodCategoryContentView.backgroundColor = .mintGreen
            }
            selectedCategory = indexPath.row
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = foodCategoryCollection.cellForItem(at: indexPath)as? FoodCategoryCollectionCell{
            cell.foodCategoryContentView.backgroundColor = .white
        }
    }
}

//MARK: CoreData
extension FoodFormViewController{
    func getAllCategory()->[FoodType]{
        guard let data = FoodCategoryRepository.shared.getAllFoodCategory() else{
            return [FoodType]()
        }
        return data
    }
    
    func saveData(foodId: String, foodName: String, foodQty: String, expDate: Date, storeDate: Date, foodTypeId: Int, measuremnt: String)-> Bool{
        let newData = FoodDataRepository.shared.createFoodItem(food_id: UUID().uuidString, food_type_id: foodTypeId, food_name: foodName, store_date: Date(), expire_date: expDate, food_qty: Int(foodQty) ?? 0, measurement_type: measuremnt)
        return newData
    }
    
    @objc func updateData(sender: UIBarButtonItem){
        let newQty = quantityTextField.text ?? "0"
        guard let foodId = currentFoodData.foodId else {return}
        let data = FoodDataRepository.shared.updateFoodItem(food_id: foodId, food_type_id: selectedCategory, newFoodName: foodNameView.textField.text ?? "", store_date: currentFoodData.storeDate ?? Date(), expire_date: estimationDateView.datePicker.date, newFoodQty: Int(newQty) ?? 0)
        if data{
            print("Update Successfull")
            performSegue(withIdentifier: "backToList", sender: self)
        }else{
            print("Update Unsuccessfull")
        }
    }
    
    func deleteData(foodData: FoodData?)->Bool{
        let data = FoodDataRepository.shared.deleteFoodItem(data: foodData ?? FoodData())
        return data
    }
}

//MARK: Save or Delete Operation
extension FoodFormViewController{
    func showDeleteAlert(){
        let alert = UIAlertController(title: "Are You Sure You Want To Delete This Item?", message: "This will permanently delete the item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in let data = self.deleteData(foodData: currentFoodData)
            if data{
                performSegue(withIdentifier: "backToList", sender: self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addOrDelete(){
        if dataFrom == "Add"{
            addFoodRecordButton.titleLabel?.text = "Add Fodd Item"
            let data = saveData(foodId: "", foodName: foodNameView.textField.text ?? "", foodQty: quantityTextField.text ?? "", expDate: estimationDateView.datePicker.date, storeDate: Date(), foodTypeId: selectedCategory, measuremnt: measurementTextField.text ?? "")
            if data{
                print("Save successfull")
                performSegue(withIdentifier: "backToList", sender: self)
            }else{
                print("Save unsuccessfull")
            }
        }else{
            addFoodRecordButton.titleLabel?.text = "Delete Food Item"
            showDeleteAlert()
//            let data = deleteData(foodData: currentFoodData)
//            if data{
//                print("successfull delete")
//                performSegue(withIdentifier: "backToList", sender: self)
//            }else{
//                print("failed to delete")
//            }
        }
    }
    
  
}
