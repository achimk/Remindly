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

final class CreateChecklistFlow: FlowPresenter {
    let screen: CreateChecklistScreen
    let presenter = ProxyPresenter<UIViewController>()
    
    override init() {
        let handler = Handler()
        let navigationBarComponent = CreateChecklistBarComponent(
            onSelectCancel: { handler.onCancel?() },
            onSelectSave: { handler.onSave?() }
        )
        let formComponent = CreateChecklistComponent()
        
        self.screen = CreateChecklistScreen(
            navigationBarComponent: navigationBarComponent,
            formComponent: formComponent
        )
        
        super.init()
        
        handler.onCancel = { [weak self] in self?.dismiss() }
        handler.onSave = { [weak self] in self?.dismiss() }
    }
    
    override func present(_ content: ViewPresenter) {
        let viewController = CreateChecklistViewController()
        
        screen.navigationBarComponent.attach(viewController.navigationBar)
        screen.formComponent.attach(viewController)
        
        presenter.source = content
        presenter.present(viewController)
    }
    
    override func dismiss() {
        screen.navigationBarComponent.detach()
        screen.formComponent.detach()
        
        presenter.dismiss()
    }
}

extension CreateChecklistFlow {
    private final class Handler {
        var onCancel: (() -> Void)?
        var onSave: (() -> Void)?
    }
}
