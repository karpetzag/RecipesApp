//
//  RecipesListRecipesListConfiguratorTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipesListModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
 
    
    func testConfigureModuleForViewController() {

        //given
        let viewController = RecipesListViewController()
        let configurator = RecipesListModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "RecipesListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RecipesListPresenter, "output is not RecipesListPresenter")

        let presenter: RecipesListPresenter = viewController.output as! RecipesListPresenter
        XCTAssertNotNil(presenter.view, "view in RecipesListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RecipesListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RecipesListRouter, "router is not RecipesListRouter")

        let interactor: RecipesListInteractor = presenter.interactor as! RecipesListInteractor
        XCTAssertNotNil(interactor.output, "output in RecipesListInteractor is nil after configuration")
    }

    class RecipesListViewControllerMock: BaseViewMock, RecipesListViewInput {
        func update(viewModel: RecipePreviewViewModel, atIndex: Int) {
            
        }
        
        
        var setupInitialStateDidCall = false

        
        func endUpdate(withRecipes: [RecipePreviewViewModel]) {
            
        }
        
         func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
