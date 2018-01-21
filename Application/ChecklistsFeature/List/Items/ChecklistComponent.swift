//
//  ChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Reminders
import Gears

public protocol ChecklistViewable: class {
    func setup(with checklist: Checklist)
}

public final class ChecklistComponent: Component<ChecklistViewable> {
    let presenter: ChecklistPresenter
    
    public init(item: Checklist) {
        self.presenter = ChecklistPresenter(item: item)
    }
    
    public override func attach(_ content: ChecklistViewable) {
        presenter.view = content
        presenter.didLoadView()
    }
    
    public override func detach() {
        presenter.view = nil
    }
}
