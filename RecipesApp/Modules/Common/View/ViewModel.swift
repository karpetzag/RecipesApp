//
//  ViewModelUpdatable.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

protocol ViewModel  {
    
}

protocol ViewModelUpdatable {
    associatedtype T: ViewModel
    
    func update(withViewModel vm: T)
}
