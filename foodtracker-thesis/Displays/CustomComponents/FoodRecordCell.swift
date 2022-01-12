//
//  FoodRecordCell.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 22/12/21.
//

import UIKit

class FoodRecordCell: UITableViewCell {

    @IBOutlet weak var foodItemName: UILabel!
    @IBOutlet weak var foodItemQty: UILabel!
    @IBOutlet weak var foodItemCategory: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
