//
//  CompostDataRepsitory.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit
import CoreData

class CompostDataRepository{
    static let shared = CompostDataRepository()
    let entityName = CompostData.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
}
