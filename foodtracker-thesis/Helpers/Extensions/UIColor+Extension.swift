//
//  UIColor+Extension.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 03/01/22.
//

import Foundation
import UIKit

extension UIColor{
    static let mintGreen = UIColor.color(named: "mintGreen")
    static let orangeTint = UIColor.color(named: "orangeTint")
    
    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}
