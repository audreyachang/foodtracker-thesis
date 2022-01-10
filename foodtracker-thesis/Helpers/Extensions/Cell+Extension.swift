//
//  Cell+Extension.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 22/12/21.
//

import UIKit

extension UIViewController: XIBIdentifiable {}

extension UITableViewCell: XIBIdentifiable {}

extension UICollectionViewCell: XIBIdentifiable {}

protocol XIBIdentifiable {
    static var id: String { get }
    static var nib: UINib { get }
}

extension XIBIdentifiable {
    static var id: String {
        String(describing: Self.self)
    }

    static var nib: UINib {
        UINib(nibName: id, bundle: nil)
    }
}
