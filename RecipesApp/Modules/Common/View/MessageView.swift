//
//  MessageView.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import UIKit

protocol MessageView {
    
    func show(errorMessage: String)
}

extension UIViewController: MessageView {
    
    func show(errorMessage: String) {
        let alert = UIAlertController(title: R.string.localizable.commonError(),
                                      message: errorMessage,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: R.string.localizable.commonOk(), style: .default, handler: nil)
    
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
