//
//  WasteTypeRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation
import UIKit
import CoreData

class WasteTypeRepository{
    static let shared = WasteTypeRepository()
    let entityName = WasteType.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createWasteType(waste_type_id: Int, waste_type_name: String)->Bool{
        do{
            let wasteType = WasteType(context: context)
            wasteType.wasteTypeId = Int32(waste_type_id)
            wasteType.wasteTypeName = waste_type_name
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    func getWasteTypeById(id: Int)->WasteType?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "wasteTypeId == %d", id as CVarArg)
        do{
            let item = try context.fetch(fetchRequest)as? [WasteType]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
}
