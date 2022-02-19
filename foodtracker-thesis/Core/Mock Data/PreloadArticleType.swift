//
//  PreloadArticleType.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation

func preloadArticleType(){
    ArticleTypeRepository.shared.createArticleType(article_type_id: 0, article_type_name: "Composting")
    ArticleTypeRepository.shared.createArticleType(article_type_id: 1, article_type_name: "Food Prep")
    ArticleTypeRepository.shared.createArticleType(article_type_id: 2, article_type_name: "Food Storing")
}
