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
import CoreApp

final class ListChecklistFlow: FlowPresenter {
    let screen: ListChecklistScreen
    let presenter = ProxyPresenter<UIViewController>()
    
    init(router: RouterType, items: [Checklist]) {
        
        let navigationBarComponent = ListChecklistBarComponent {
            router.open(.createChecklist)
        }
        
        let listComponent = ListChecklistComponent(items: items)
        
        self.screen = ListChecklistScreen(
            navigationBarComponent: navigationBarComponent,
            listComponent: listComponent
        )
        
        super.init()
    }
    
    override func present(_ content: ViewPresenter) {
        let viewController = ListChecklistViewController(style: .grouped)
        screen.navigationBarComponent.attach(viewController.navigationBar)
        screen.listComponent.attach(viewController.dataSource)
        
        presenter.source = content
        presenter.present(viewController)
    }
    
    override func dismiss() {
        screen.navigationBarComponent.detach()
        screen.listComponent.detach()
        
        presenter.dismiss()
    }
}
