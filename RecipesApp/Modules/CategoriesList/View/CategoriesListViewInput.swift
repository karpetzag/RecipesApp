//
//  CategoriesListCategoriesListViewInput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

protocol CategoriesListViewInput: class, LoadingView, MessageView {
 
    func setupInitialState()
    
    func endUpdate(withCategories: [CategoryViewModel])
}
