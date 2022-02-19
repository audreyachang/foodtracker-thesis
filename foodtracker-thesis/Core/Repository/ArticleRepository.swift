//
//  ArticleRepository.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation
import CoreData
import UIKit

class ArticleRepository{
    static let shared = ArticleRepository()
    let entityName = Article.self.description()
    let context =  CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func createArticle(article_id: Int, article_title: String, article_content: String, article_type_id: Int){
        do{
            let article = Article(context: context)
            article.articleId = Int32(article_id)
            article.articleTitle = article_title
            article.articleContent = article_content
            if let ArticleTypes = ArticleTypeRepository.shared.getArticleTypeById(id: article_type_id){
                article.articleTypeId = ArticleTypes.articleTypeId
            }
            
            try context.save()
        
        }catch let error as NSError{
            print(error)
        }
       
    }
    
    func getAllArticles()->[Article]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do{
            let item = try context.fetch(fetchRequest)as? [Article]
            return item
        }catch let error as NSError{
            print(error)
        }
        return []
    }
    
    func getArticleById(id: Int)-> Article?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "articleId == %d", id as CVarArg)
        do{
            let item = try context.fetch(fetchRequest)as? [Article]
            return item?.first
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
}
