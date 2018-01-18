//
//  CreateChecklistFlow.swift
//  Remindly
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import ChecklistsFeature
import Reminders
import Gears

struct CreateChecklistFlow {
    let navigation: UINavigationController
    let component: Component<CreateChecklistViewable>
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        self.component = CreateChecklistComponent()
    }
    
    func present() {
        let viewController = CreateChecklistViewController()
        component.attach(viewController)
        
        navigation.pushViewController(viewController, animated: isAnimated())
    }
    
    func dismiss() {
        component.detach()
        
        navigation.popViewController(animated: isAnimated())
    }
    
    private func isAnimated() -> Bool {
        return navigation.viewControllers.count > 1
    }
}
