//
//  RecipeCollectionViewCell.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 09/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import AlamofireImage

struct RecipePreviewViewModel: ViewModel {
    
    let title: String
    let previewURL: URL?
    let isFavorite: Bool
}

class RecipeCollectionViewCell: UICollectionViewCell, ViewModelUpdatable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    func update(withViewModel vm: RecipePreviewViewModel) {
        titleLabel.text = vm.title
        
        imageView.image = nil
        if let url = vm.previewURL {
            imageView.af_setImage(withURL: url)
        }
        
        favoriteImageView.isHidden = !vm.isFavorite
    }
}
