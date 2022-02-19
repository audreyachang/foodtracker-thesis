//
//  CompostListViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class CompostListViewController: UIViewController {

    @IBOutlet weak var compostSegmented: UISegmentedControl!
    @IBOutlet weak var compostListTable: UITableView!
    
    var compostData = [CompostDetail]()
    var compostHeader = [CompostData]()
    var displayedCompost = [CompostDetail]()
    var currentCompost = CompostDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getAllCompost()
        filterDisplayedData()
        compostSegmented.addTarget(self, action: #selector(reloadTableView(sender:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        getAllCompost()
        filterDisplayedData()
        compostSegmented.addTarget(self, action: #selector(reloadTableView(sender:)), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
        filterDisplayedData()
        compostSegmented.addTarget(self, action: #selector(reloadTableView(sender:)), for: .valueChanged)
    }

}

extension CompostListViewController{
    func setup(){
        self.title = "Compost List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(self.addCompost(sender:)))
        compostListTable.register(UINib(nibName: "CompostTableCell", bundle: nil), forCellReuseIdentifier: "CompostTableCell")
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .orangeTint
    }
}

extension CompostListViewController{
    @IBAction func unwindToCompostList(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @objc func addCompost(sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "CompostForm", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "goToCompostForm")as! CompostFormViewController
        vc.dataFrom = "Add"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func reloadTableView(sender: UISegmentedControl){
        filterDisplayedData()
    }
}
extension CompostListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCompost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = compostListTable.dequeueReusableCell(withIdentifier: "CompostTableCell", for: indexPath)as! CompostTableCell
        currentCompost = CompostDetailRepository.shared.getCompostDetailById(compost_id: compostData[indexPath.row].compostId ?? "") ?? CompostDetail()
        cell.compostName.text = currentCompost.compostName
        cell.compostPhase.text = currentCompost.compostPhase
        let compostHarvest = CompostDataRepository.shared.getCompostDataById(compost_id: currentCompost.compostId ?? "")
        cell.compostProcess.text = String(compostHarvest?.completionDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
        if currentCompost.compostPhase != "Harvested"{
        cell.phaseButton.setTitle("Harvest", for: .normal)
            
        cell.editButtonAction = {
            let data = CompostDetailRepository.shared.updateCompostDetail(compost_id: self.currentCompost.compostId ?? "", new_phase: "Harvested")
            
            if data{
                cell.phaseButton.isEnabled = false
                cell.phaseButton.setTitle("Harvested", for: .disabled)
                cell.phaseButton.setTitleColor(.white, for: .disabled)
                cell.phaseButton.layer.opacity = 0.2
                }
            }
        }else{
            cell.phaseButton.isEnabled = false
            cell.phaseButton.setTitle("Harvested", for: .disabled)
            cell.phaseButton.setTitleColor(.white, for: .disabled)
            cell.phaseButton.layer.opacity = 0.2
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "CompostForm", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "goToCompostForm")as! CompostFormViewController
        vc.dataFrom = "Edit"
        vc.currentCompostId = displayedCompost[indexPath.row].compostId ?? ""
        vc.currentType = Int(displayedCompost[indexPath.row].compostTypeId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CompostListViewController{
    func getAllCompost(){
        compostData = getAllDetail()
        compostHeader = getAllHeader()
        
        print(compostData)
        print(compostHeader)
    }
    
    func getAllDetail()->[CompostDetail]{
        guard let data = CompostDetailRepository.shared.getAllCompostDetail() else {
            return [CompostDetail]()
        }
        return data
    }
    
    func getAllHeader()->[CompostData]{
        guard let data = CompostDataRepository.shared.getAllCompostData() else {
            return [CompostData]()
        }
        return data
    }
    
    func filterDisplayedData(){
        displayedCompost = [CompostDetail]()
        if compostSegmented.selectedSegmentIndex == 0 {
            for i in 0..<compostData.count {
                if compostData[i].compostTypeId == 0 {
                    displayedCompost.insert(compostData[i], at: displayedCompost.count)
                }
            }
        }else{
            for i in 0..<compostData.count {
                if compostData[i].compostTypeId == 1 {
                    displayedCompost.insert(compostData[i], at: displayedCompost.count)
                }
            }
        }
        compostListTable.reloadData()
    }
}
