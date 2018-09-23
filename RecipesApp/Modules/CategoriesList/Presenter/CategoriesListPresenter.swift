//
//  CategoriesListCategoriesListPresenter.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

class CategoriesListPresenter: CategoriesListModuleInput, CategoriesListViewOutput {
   
    weak var view: CategoriesListViewInput!
    var interactor: CategoriesListInteractorInput!
    var router: CategoriesListRouterInput!

    private var categories = [Category]()
    
    func viewIsReady() {
        view.setupInitialState()
        startLoadData()
    }
    
    func didSelectCategory(atIndex index: Int) {
        let category = categories[index]
        router.showRecipes(forCategory: category)
    }
    
    func onViewRefesh() {
        interactor.loadCategories()
    }

    private func startLoadData() {
        view.showLoading()
        interactor.loadCategories()
    }
    
    private func viewModelFromCategory(category: Category) -> CategoryViewModel {
        return CategoryViewModel(title: category.title,
                                 imageURL: category.imageURL,
                                 description: category.description.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

extension CategoriesListPresenter: CategoriesListInteractorOutput {
    
    func didLoadCategories(result: InteractorFetchResult<[Category]>) {
        view.hideLoading()
        
        if let items = result.resultItem {
            self.categories = items
            let viewModels = categories.map(viewModelFromCategory)
            view.endUpdate(withCategories: viewModels)
        } else if result.requestResult.error != nil {
            view.endUpdate(withCategories: [])
            view.show(errorMessage: R.string.localizable.categoriesError())
        }
    }
    
}
