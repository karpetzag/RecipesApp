//
//  RecipesListRecipesListViewInput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//


protocol RecipesListViewInput: class, MessageView, LoadingView {

    func setupInitialState()
    
    func endUpdate(withRecipes: [RecipePreviewViewModel])
    
    func update(viewModel: RecipePreviewViewModel, atIndex: Int)
}
