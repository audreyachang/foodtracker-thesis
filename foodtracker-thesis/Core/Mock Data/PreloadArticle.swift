//
//  PreloadArticle.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation

func preloadArticle(){
    ArticleRepository.shared.createArticle(article_id: 0, article_title: "What is Compost", article_content: "Composting is a set of activities done to control and manage the process of making compost. Activities include making a balanced mixture of organic materials, adding activators and provisioning water.\nHow to Compost\n- Prepare a composter(container)\n- Prepare brown and green trash\n- Mix in the ingredients\n- Add Activator or decomposter\n- Let it rest and stir weekly\n- Harvest the compost", article_type_id: 0)
    ArticleRepository.shared.createArticle(article_id: 1, article_title: "How to Store Leftovers", article_content: "Storing food properly ia a good way to maintain it's fresheness. The same goes for leftovers, by storing it properly it could stay for much longer thus helping to reduce amounts of food waste produced. The following are some ways to store your food:\n- Store it in the fridge, it helps prevent bacterias from multiplying\n- Divide your food into small containers\n- Separate different foods to maintain its taste and freshness\n- Store it in the freezer and reheat it with the appropriate temperature before eating\n- Don't use materials such as plastic when reheating food", article_type_id: 2)
    ArticleRepository.shared.createArticle(article_id: 2, article_title: "Food Preparation Facts", article_content: "Though preparing food might seem like a hassle, there are actually a number of benefits in doing it, some of those benefits include:\n- Saving time when cooking, Food prep not only helps save time it also helps you save your energy as it's already been prepared beforehand\n- Helps manage your eating portions, this is because prepping before you need to use ingredients means it's easier to measure out the amount needed.\n- Helps increase cooking skills as well as increase knowledge of an ingredient's nutitional value.", article_type_id: 1)
    ArticleRepository.shared.createArticle(article_id: 3, article_title: "Composting Methods to Try Out", article_content: "If you are a beginner whose looking to start composting on your own, here are some methods that we recommend you try:\n- Worm Bin Composting, which is a composting method that uses a worm to help break down the ingredients into the compost\n- Biopori Compossting, a composting method that takes place underground, this method could process all kinds of material including wet, fatty, and oily organic waste such as bones\n- Bagasse composting, which is an effective composting method made from Bagasse and Cow Dung as a bioactivator", article_type_id: 0)
}
