//
//  BaseViewMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 12/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp


class BaseViewMock: LoadingView, MessageView {
    
    var showErrorIsCalled = false
    var showErrorMessageIsCalled = false
    
    func hideLoading() {
        
    }
    
    func showLoading() {
        
    }
    
    func show(error: Error) {
        showErrorIsCalled = true
    }
    
    func show(errorMessage: String) {
        showErrorMessageIsCalled = true
    }
    
}
