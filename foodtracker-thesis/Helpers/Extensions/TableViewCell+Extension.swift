//
//  TableViewCell+Extension.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 22/12/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
