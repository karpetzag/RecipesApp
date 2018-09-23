//
//  RecipeDetailsRecipeDetailsConfiguratorTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest

class RecipeDetailsModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = RecipeDetailsViewControllerMock()
        let configurator = RecipeDetailsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "RecipeDetailsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RecipeDetailsPresenter, "output is not RecipeDetailsPresenter")

        let presenter: RecipeDetailsPresenter = viewController.output as! RecipeDetailsPresenter
        XCTAssertNotNil(presenter.view, "view in RecipeDetailsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RecipeDetailsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RecipeDetailsRouter, "router is not RecipeDetailsRouter")

        let interactor: RecipeDetailsInteractor = presenter.interactor as! RecipeDetailsInteractor
        XCTAssertNotNil(interactor.output, "output in RecipeDetailsInteractor is nil after configuration")
    }

    class RecipeDetailsViewControllerMock: RecipeDetailsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
