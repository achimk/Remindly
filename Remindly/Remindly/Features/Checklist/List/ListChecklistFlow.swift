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
    let screen: ListChecklistScreen
    
    init(navigation: UINavigationController, items: [Checklist]) {
        
        let navigationBarComponent = ListChecklistBarComponent {
            let flow = CreateChecklistFlow(rootViewController: navigation)
            flow.present()
        }
        
        let listComponent = ListChecklistComponent(items: items)
        
        self.screen = ListChecklistScreen(
            navigationBarComponent: navigationBarComponent,
            listComponent: listComponent
        )
        
        self.navigation = navigation
    }
    
    func present() {
        let viewController = ListChecklistViewController()
        screen.navigationBarComponent.attach(viewController.navigationBar)
        screen.listComponent.attach(viewController)
        
        navigation.pushViewController(viewController, animated: isAnimated())
    }
    
    func dismiss() {
        screen.navigationBarComponent.detach()
        screen.listComponent.detach()
        
        navigation.popViewController(animated: isAnimated())
    }
    
    private func isAnimated() -> Bool {
        return navigation.viewControllers.count > 1
    }
}
