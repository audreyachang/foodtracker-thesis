//
//  FoodFormViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class FoodFormViewController: UIViewController {

    @IBOutlet weak var foodCategoryCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
}

//MARK: Initial Setup
extension FoodFormViewController{
    func setup(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "New Food Item"
        foodCategoryCollection.register(UINib(nibName: "FoodCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FoodCategoryCollectionCell")
        foodCategoryCollection.delegate = self
        foodCategoryCollection.dataSource = self
        foodCategoryCollection.reloadData()
    }
}

//MARK: CollectionViewDelegate
extension FoodFormViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCategoryCollection.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCollectionCell", for: indexPath)as! FoodCategoryCollectionCell
        cell.selectedBackgroundView?.backgroundColor = .blue
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

