//
//  ArticleListViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet weak var articleListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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

extension ArticleListViewController{
    func setup(){
        self.title = "Food Sustainability"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        articleListTable.register(UINib(nibName: "ArticleListCell", bundle: nil), forCellReuseIdentifier: "ArticleListCell")
        
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleListTable.dequeueReusableCell(withIdentifier: "ArticleListCell", for: indexPath)as! ArticleListCell
        cell.titleLabel.text = "Example 1"
        cell.articleImage.image = UIImage.actions
        cell.tagLabel.text = "Tag Example"
        return cell
    }
    
    
}
