//
//  NavigatorMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 23/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class MockNavigator<InputType>: Navigatior {
    var setupHandler: ((InputType) -> ())?
    
    func navigate<T>(withSegueId id: String, type: T.Type, setupHandler: ((T) -> ())?) {
        self.setupHandler = setupHandler as! ((InputType) -> ())?
    }
}
