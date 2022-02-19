//
//  ArticleListViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet weak var articleListTable: UITableView!
    var articlesData = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        if ArticleRepository.shared.getAllArticles()?.count == 0 {
            preloadArticle()
            preloadArticleType()
        }
        getAllArticle()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
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
extension ArticleListViewController{
    func setUp(){
        self.title = "Food Sustainability"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        articleListTable.register(UINib.init(nibName: "ArticleTableCell", bundle: nil), forCellReuseIdentifier: "ArticleTableCell")
        articleListTable.layoutMargins = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        articleListTable.separatorInset = .zero
    }
}

//MARK: Table View Delegate
extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleListTable.dequeueReusableCell(withIdentifier: "ArticleTableCell", for: indexPath)as! ArticleTableCell
        cell.accessoryView?.tintColor = .orangeTint
        cell.articleTitle.text = articlesData[indexPath.section].articleTitle
        if indexPath.section == 1 {
            cell.articleTag.text = "Food Storing"
        }else if indexPath.section == 2 {
            cell.articleTag.text = "Food Prep"
        }else{
            cell.articleTag.text = "Composting"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ArticleDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "goToArticleDetail")as! ArticleDetailViewController
        vc.articleData = articlesData[indexPath.section]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleListViewController{
    func getAllArticle(){
        articlesData = getAllArticles()
    }
    
    func getAllArticles()->[Article]{
        guard let data = ArticleRepository.shared.getAllArticles() else {
            return [Article]()
        }
        return data
    }
}
