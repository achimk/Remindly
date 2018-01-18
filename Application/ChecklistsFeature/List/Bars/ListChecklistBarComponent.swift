//
//  ListChecklistBarComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public protocol ListChecklistBarViewable: class {
    var eventListener: ListChecklistBarEventListening? { get set }
    func show(title: String)
}

public final class ListChecklistBarComponent: Component<ListChecklistBarViewable> {
    let presenter: ListChecklistBarPresenter
    
    public init(_ onSelectCreateChecklist: (() -> Void)?) {
        self.presenter = ListChecklistBarPresenter(onSelectCreateChecklist)
    }
    
    public override func attach(_ content: ListChecklistBarViewable) {
        content.eventListener = presenter
        presenter.view = content
        presenter.didLoadView()
    }
    
    public override func detach() {
        presenter.view?.eventListener = nil
        presenter.view = nil
    }
}
