//
//  CompostTableCell.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 22/12/21.
//

import UIKit

class CompostTableCell: UITableViewCell {

    @IBOutlet weak var compostProcess: UILabel!
    @IBOutlet weak var compostName: UILabel!
    @IBOutlet weak var compostPhase: UILabel!
    @IBOutlet weak var phaseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
