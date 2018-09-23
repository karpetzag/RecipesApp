//
//  RecipeDetailsRecipeDetailsViewInput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

protocol RecipeDetailsViewInput: class, LoadingView, MessageView {
    
    func markAsAddedToFavorites()
    
    func markAsRemovedFromFavorites()
    
    func set(viewModel: RecipeDetailsViewModel)
}
