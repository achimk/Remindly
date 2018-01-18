//
//  ListChecklistFlow.swift
//  Remindly
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import ChecklistsFeature
import Reminders
import Gears

struct ListChecklistFlow {
    let navigation: UINavigationController
    let component: Component<ListChecklistViewable>
    
    init(navigation: UINavigationController, items: [Checklist]) {
        self.navigation = navigation
        self.component = ListChecklistComponent(items: items)
    }
    
    func present() {
        let viewController = ListChecklistViewController()
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
