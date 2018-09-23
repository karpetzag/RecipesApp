//
//  RecipesListRecipesListViewOutput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

protocol RecipesListViewOutput {

    func viewIsReady()
    
    func onViewRefesh()
    
    func didSelectRecipe(atIndex index: Int)

}
