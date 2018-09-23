//
//  LoadingView.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 09/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol LoadingView {
    
    func showLoading()
    
    func hideLoading()
}

extension UIViewController: LoadingView {
    
    func showLoading() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = R.string.localizable.commonLoading()
        hud.show(in: view, animated: true)
    }
    
    func hideLoading() {
        guard let foundView = view.subviews.first(where: { $0 is JGProgressHUD }), let hud = foundView as? JGProgressHUD else {
            return
        }
        
        hud.dismiss(animated: true)
    }
    
}
