//
//  CompostFormViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class CompostFormViewController: UIViewController {
    @IBOutlet weak var addOrDeleteButton: UIButton!
    @IBOutlet weak var compostTypeCollection: UICollectionView!
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var compostHarvestView: LabelWithDate!
    @IBOutlet weak var compostNameView: LabelWithTextField!
    
    var dataFrom = ""
    var selectedType = Int()
    var currentType = 0
    var compostType = [CompostType]()
    var currentCompost = CompostData()
    var currentCompostId = ""
    var compostDetail = CompostDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if CompostTypeRepository.shared.getAllCompostType()?.count == 0 {
            preloadCompostType()
        }
        selectedType = currentType
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView(compostTypeCollection, didSelectItemAt: IndexPath(row: currentType, section: 0))
    }
    
    
    @IBAction func addOrDeleteAction(_ sender: Any) {
        addOrDelete()
    }
}

extension CompostFormViewController{
    func setup(){
        self.tabBarController?.tabBar.isHidden = true
        compostTypeCollection.register(UINib(nibName: "CompostCategoryCell", bundle: nil), forCellWithReuseIdentifier: "CompostCategoryCell")
        self.title = "New Compost"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        collectionTitleLabel.text = "Type of Compost"
        compostNameView.titleLabel.text = "Compost Name"
        compostHarvestView.contentLabel.text = "Esstimation Harvest Date"
        if dataFrom == "Add"{
            compostNameView.textField.placeholder = "Enter your compost name"
            addOrDeleteButton.titleLabel?.text = "Add Compost"
        }else{
            addOrDeleteButton.titleLabel?.text = "Delete"
            currentCompost = CompostDataRepository.shared.getCompostDataById(compost_id: currentCompostId) ?? CompostData()
            compostDetail = CompostDetailRepository.shared.getCompostDetailById(compost_id: currentCompostId) ?? CompostDetail()
            compostNameView.textField.text = compostDetail.compostName
            compostHarvestView.datePicker.date = currentCompost.completionDate!
        }
    }
}

extension CompostFormViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        compostType = getAllCompostType()
        return compostType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = compostTypeCollection.dequeueReusableCell(withReuseIdentifier: "CompostCategoryCell", for: indexPath)as! CompostCategoryCell
        cell.contentLabel.text = compostType[indexPath.row].compostTypeName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentActive = compostTypeCollection.cellForItem(at: IndexPath(row: currentType, section: 0))as? CompostCategoryCell{
            currentActive.backgroudContentView.backgroundColor = .white
        }
        if let cell = compostTypeCollection.cellForItem(at: indexPath)as? CompostCategoryCell {
            cell.backgroudContentView.backgroundColor = .mintGreen
        }
        selectedType = indexPath.row
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = compostTypeCollection.cellForItem(at: indexPath)as? CompostCategoryCell{
            cell.backgroudContentView.backgroundColor = .white
        }
        
    }
    
}

extension CompostFormViewController{
    func createCompost(compostId: String, compostName: String, completionDate: Date, compostPhase: String)->Bool{
        let newCompostId = UUID().uuidString
        let newCompost = CompostDataRepository.shared.createCompostData(compost_id: newCompostId, start_date: Date(), completion_date: completionDate)
        
        let newCompostDetail = CompostDetailRepository.shared.createCompostDetail(compost_id: newCompostId, compost_type_id: selectedType, compost_name: compostName, compost_phase: "Harvest")
        
        if newCompost && newCompostDetail == true {
            return true
        }else{
            return false
        }
    }
    
    func addOrDelete(){
        if dataFrom == "Add"{
            addOrDeleteButton.titleLabel?.text = "Add Compost"
            let data = createCompost(compostId: "", compostName: compostNameView.textField.text ?? "", completionDate: compostHarvestView.datePicker.date, compostPhase: "Harvest")
            
            if data {
                print("Add Successfull")
                self.performSegue(withIdentifier: "backToCompostList", sender: self)
            }else{
                print("Add Failed")
            }
        }else{
            addOrDeleteButton.titleLabel?.text = "Delete Compost"
            showDeleteAlert()
        }
        
    }
    func getAllCompostType()->[CompostType]{
        guard let data = CompostTypeRepository.shared.getAllCompostType() else{
            return [CompostType]()
        }
        return data
    }
    
    func showDeleteAlert(){
        let alert = UIAlertController(title: "Are You Sure You Want To Delete This Item?", message: "This will permanently delete the item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in let data = self.deleteCompostData(compostData: currentCompost)
            if data{
                performSegue(withIdentifier: "backToCompostList", sender: self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteCompostData(compostData: CompostData?)-> Bool{
        let detail = CompostDetailRepository.shared.getCompostDetailById(compost_id: (compostData?.compostId)!)
        
        let data =  CompostDataRepository.shared.deleteCompostData(data: compostData ?? CompostData())
        
        let detailData = CompostDetailRepository.shared.deleteCompostData(data: detail ?? CompostDetail())
        
        if data && detailData == true {
            return true
        }else{
            return false
        }
    }
    
}

