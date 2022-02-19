//
//  ArticleTableCell.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 11/02/22.
//

import UIKit

class ArticleTableCell: UITableViewCell {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleTag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
