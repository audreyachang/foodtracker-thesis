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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
 
}

