//
//  ArticleTypeRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation
import UIKit
import CoreData

class ArticleTypeRepository{
    static let shared = ArticleTypeRepository()
    let entityName = ArticleType.self.description()
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createArticleType(article_type_id: Int,
                           article_type_name: String){
        do{
            let articleType = ArticleType(context: context)
            articleType.articleTypeId = Int32(article_type_id)
            articleType.articleTypeName = article_type_name
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }

    func getArticleTypeById(id: Int)->ArticleType? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "articleTypeId == %d", id as CVarArg)
        do{
            let item = try context.fetch(fetchRequest)as? [ArticleType]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
}

