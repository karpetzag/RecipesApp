//
//  Router.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 13/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import UIKit
import LightRoute

class Router {
    
    var navigator: Navigatior?
    
}

protocol Navigatior: class {
    
    func navigate<T>(withSegueId id: String, type: T.Type, setupHandler: ((T)->())?)
    
}

class DefaultNavigatior: Navigatior {
    
    private weak var transitionHandler: TransitionHandler?
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
    
    func navigate<T>(withSegueId id: String, type: T.Type, setupHandler: ((T)->())?) {
        try? transitionHandler?.forSegue(identifier: id, to: type).then({ (input) -> Any? in
                setupHandler?(input)
                return nil
        })
    }
}
