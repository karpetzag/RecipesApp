//
//  CategoriesListCategoriesListConfiguratorTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class CategoriesListModuleConfiguratorTests: XCTestCase {

    func testConfigureModuleForViewController() {

        //given
        let viewController = CategoriesListViewControllerMock()
        let configurator = CategoriesListModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "CategoriesListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is CategoriesListPresenter, "output is not CategoriesListPresenter")

        let presenter: CategoriesListPresenter = viewController.output as! CategoriesListPresenter
        XCTAssertNotNil(presenter.view, "view in CategoriesListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in CategoriesListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is CategoriesListRouter, "router is not CategoriesListRouter")

        let interactor: CategoriesListInteractor = presenter.interactor as! CategoriesListInteractor
        XCTAssertNotNil(interactor.output, "output in CategoriesListInteractor is nil after configuration")
    }

    class CategoriesListViewControllerMock: CategoriesListViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
