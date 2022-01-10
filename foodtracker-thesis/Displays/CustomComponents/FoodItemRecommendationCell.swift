//
//  FoodItemRecommendationCell.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import UIKit

class FoodItemRecommendationCell: UICollectionViewCell {

    
    @IBOutlet weak var cellContentView: DesignableButton!
    @IBOutlet weak var foodItemLabel: UILabel!
    @IBOutlet weak var foodQtyLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
