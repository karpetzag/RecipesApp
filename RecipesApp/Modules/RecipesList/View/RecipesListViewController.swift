//
//  RecipesListRecipesListViewController.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController, RecipesListViewInput {

    var output: RecipesListViewOutput!

    private let refreshControl = UIRefreshControl()

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var cellViewModels = [RecipePreviewViewModel]()
    
    // MARK: Life cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    func update(viewModel: RecipePreviewViewModel, atIndex index: Int) {
        cellViewModels.remove(at: index)
        cellViewModels.insert(viewModel, at: index)
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func endUpdate(withRecipes recipes: [RecipePreviewViewModel]) {
        refreshControl.endRefreshing()
        cellViewModels = recipes
        collectionView.reloadData()
    }
    
    func setupInitialState() {
        collectionView.register(R.nib.recipeCollectionViewCell)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullRefreshHandler), for: .valueChanged)
        navigationItem.title = R.string.localizable.recipesListTitle()
    }
 
    //MARK: Actions
    
    @objc
    private func pullRefreshHandler() {
        output.onViewRefesh()
    }
}
 
extension RecipesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectRecipe(atIndex: indexPath.row)
    }
    
}

extension RecipesListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.recipeCollectionViewCell, for: indexPath) else {
            fatalError("Invalid cell id")
        }
        
        let vm = cellViewModels[indexPath.row]
        cell.update(withViewModel: vm)
        return cell
    }
}
