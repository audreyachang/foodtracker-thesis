//
//  ArticleDetailViewController.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 04/01/22.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var contentLabel: UILabel!
    var articleData = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        self.title = articleData.articleTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .mintGreen
        self.navigationController?.navigationBar.tintColor = .orangeTint
        self.tabBarController?.tabBar.isHidden = true
        contentLabel.text = articleData.articleContent
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
