//
//  RecipeDetailsRecipeDetailsViewController.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

struct RecipeDetailsViewModel: ViewModel {
    
    let name: String
    let instructions: String
    let ingredients: String
    let imageURL: URL?
}

class RecipeDetailsViewController: UIViewController, RecipeDetailsViewInput {
    
    var output: RecipeDetailsViewOutput!

    @IBOutlet private weak var instructionsLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ingredientsTitleLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
  
    func set(viewModel: RecipeDetailsViewModel) {
        ingredientsTitleLabel.text = R.string.localizable.detailsIngredients()
        nameLabel.text = viewModel.name
        ingredientsLabel.text = viewModel.ingredients
        instructionsLabel.text = viewModel.instructions
        
        if let url = viewModel.imageURL {
            imageView.af_setImage(withURL: url)
        }
    }
    
    func markAsAddedToFavorites() {
        setupAddToFavoriteButton(title: R.string.localizable.detailsFavoritesRemove())
    }
    
    func markAsRemovedFromFavorites() {
        setupAddToFavoriteButton(title: R.string.localizable.detailsFavoritesAdd())
    }
    
    private func setupAddToFavoriteButton(title: String) {
        let button = UIBarButtonItem(title: title,
                                     style: .plain,
                                     target: self,
                                     action: #selector(onFavoriteButtonTap))
        navigationItem.rightBarButtonItem = button
    }
    
    // MARK: Actions
    
    @objc
    private func onFavoriteButtonTap() {
        output.changeFavoriteStatus()
    }
}
