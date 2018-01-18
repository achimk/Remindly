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
    let rootViewController: UIViewController
    let screen: CreateChecklistScreen
    
    init(rootViewController: UIViewController) {
        
        let navigationBarComponent = CreateChecklistBarComponent(
        onSelectCancel: {
            print("-> on cancel...")
        }, onSelectSave: {
            print("-> on save...")
        })
        let formComponent = CreateChecklistComponent()
        
        self.screen = CreateChecklistScreen(
            navigationBarComponent: navigationBarComponent,
            formComponent: formComponent
        )
        
        self.rootViewController = rootViewController
    }
    
    func present() {
        let navigationController = UINavigationController()
        let viewController = CreateChecklistViewController()
        navigationController.viewControllers = [viewController]
        
        screen.navigationBarComponent.attach(viewController.navigationBar)
        screen.formComponent.attach(viewController)
        
        rootViewController.present(navigationController, animated: true, completion: nil)
    }
    
    func dismiss() {
        screen.navigationBarComponent.detach()
        screen.formComponent.detach()
        
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
