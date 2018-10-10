//
//  CategoriesListCategoriesListViewOutput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

protocol CategoriesListViewOutput {
 
    func viewIsReady()
    
    func didSelectCategory(atIndex index: Int)
    
    func onViewRefresh()

}
