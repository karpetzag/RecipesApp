//
//  CategoryCollectionViewCell.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import UIKit
 
struct CategoryViewModel: ViewModel {
    
    let title: String
    let imageURL: URL?
    let description: String
}

class CategoryCollectionViewCell: UICollectionViewCell, ViewModelUpdatable {
  
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    
    func update(withViewModel vm: CategoryViewModel) {
        descriptionLabel.text = vm.description
        titleLabel.text = vm.title
        
        imageView.image = nil
        if let url = vm.imageURL {
            imageView.af_setImage(withURL: url)
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }

    func set(width: CGFloat) {
        widthConstraint.constant = width
        setNeedsLayout()
    }
}
