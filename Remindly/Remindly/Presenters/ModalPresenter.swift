//
//  ModalPresenter.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

final class ModalPresenter: ViewPresenter {
    let rootViewController: UIViewController
    let isAnimated: Bool
    
    init(rootViewController: UIViewController,
         isAnimated: Bool = true) {
        
        self.rootViewController = rootViewController
        self.isAnimated = isAnimated
    }
    
    override func present(_ content: UIViewController) {
        rootViewController.present(content, animated: isAnimated, completion: nil)
    }
    
    override func dismiss() {
        rootViewController.dismiss(animated: isAnimated, completion: nil)
    }
}
