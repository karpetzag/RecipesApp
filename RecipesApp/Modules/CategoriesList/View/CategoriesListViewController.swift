//
//  CategoriesListCategoriesListViewController.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class CategoriesListViewController: UIViewController, CategoriesListViewInput {

    var output: CategoriesListViewOutput!

    private let refreshControl = UIRefreshControl()
    private var cellViewModels = [CategoryViewModel]()
    
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    func setupInitialState() {
        collectionView.register(R.nib.categoryCollectionViewCell)
        navigationItem.title = R.string.localizable.categoriesTitle()

        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullRefreshHandler), for: .valueChanged)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1,height: 1)
        }
    }
    
    func endUpdate(withCategories categories: [CategoryViewModel]) {
        refreshControl.endRefreshing()
        cellViewModels = categories
        collectionView.reloadData()
    }
    
    // MARK: Actions
    
    @objc
    private func pullRefreshHandler() {
        output.onViewRefesh()
    }
}

extension CategoriesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectCategory(atIndex: indexPath.row)
    }
}

extension CategoriesListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.categoryCollectionViewCell, for: indexPath) else {
            fatalError("Invalid cell id")
        }
        
        let vm = cellViewModels[indexPath.row]
        cell.set(widht: cellWidth())
        cell.update(withViewModel: vm)
        return cell
    }
    
    private func cellWidth() -> CGFloat {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        
        let maxWidth: CGFloat = 380
        return min(collectionView.bounds.width - flowLayout.minimumInteritemSpacing * 2, maxWidth)
    }
}
