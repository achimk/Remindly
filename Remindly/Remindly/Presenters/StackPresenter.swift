//
//  StackPresenter.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

final class StackPresenter: ViewPresenter {
    let navigationController: UINavigationController
    let isAnimated: Bool
    
    init(navigationController: UINavigationController,
         isAnimated: Bool = true) {
        
        self.navigationController = navigationController
        self.isAnimated = isAnimated
    }
    
    override func present(_ content: UIViewController) {
        navigationController.pushViewController(content, animated: isPushAnimated())
    }
    
    override func dismiss() {
        navigationController.popViewController(animated: isPopAnimated())
    }
    
    private func isPushAnimated() -> Bool {
        return navigationController.viewControllers.count > 0 && isAnimated
    }
    
    private func isPopAnimated() -> Bool {
        return navigationController.viewControllers.count > 1 && isAnimated
    }
}
