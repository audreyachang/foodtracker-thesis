//
//  CompostDetailRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 10/01/22.
//

import Foundation
import UIKit
import CoreData

class CompostDetailRepository{
    static let shared = CompostDetailRepository()
    let entityName = CompostDetail.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createCompostDetail(compost_id: String,
                             compost_type_id: Int,
                             compost_name: String,
                             compost_phase: String)->Bool{
        do{
            let compostDetail = CompostDetail(context: context)
            compostDetail.compostPhase = compost_phase
            compostDetail.compostName = compost_name
            
            if let compostHeaders = CompostDataRepository.shared.getCompostDataById(compost_id: compost_id){
                compostDetail.compostId = compostHeaders.compostId
            }
            
            if let compostTypes = CompostTypeRepository.shared.getCompostTypeById(compostTypeId: compost_type_id){
                compostDetail.compostTypeId = compostTypes.compostTypeId
            }
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    func getAllCompostDetail()->[CompostDetail]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest)as? [CompostDetail]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    func getCompostDetailById(compost_id: String)-> CompostDetail?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "compostId == '\(compost_id)'")
        do{
            let item = try context.fetch(fetchRequest)as? [CompostDetail]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    func updateCompostDetail(compost_id: String, new_phase: String)->Bool{
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "compostId == '\(compost_id)'")
            do{
            let item = try context.fetch(fetchRequest)as? [CompostDetail]
                let newCompostDetail = item?.first
                newCompostDetail?.compostPhase = new_phase
                try context.save()
                return true
            }catch let error as NSError{
                print(error)
            }
        return false
    }
    
    func deleteCompostData(data: CompostDetail)->Bool{
        do{
            context.delete(data)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
}
