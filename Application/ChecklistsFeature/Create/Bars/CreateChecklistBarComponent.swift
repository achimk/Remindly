//
//  CreateChecklistBarComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public protocol CreateChecklistBarViewable: class {
    var eventListener: CreateChecklistBarEventListening? { get set }
    func show(title: String)
}

public final class CreateChecklistBarComponent: Component<CreateChecklistBarViewable> {
    let presenter: CreateChecklistBarPresenter
    
    public init(onSelectCancel: (() -> Void)?,
                onSelectSave: (() -> Void)?) {
        
        self.presenter = CreateChecklistBarPresenter(
            onSelectCancel: onSelectCancel,
            onSelectSave: onSelectSave
        )
    }
    
    public override func attach(_ content: CreateChecklistBarViewable) {
        content.eventListener = presenter
        presenter.view = content
        presenter.didLoadView()
    }
    
    public override func detach() {
        presenter.view?.eventListener = nil
        presenter.view = nil
    }
}
