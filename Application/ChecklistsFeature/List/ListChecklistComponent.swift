//
//  ListChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears
import Reminders

public protocol ListChecklistDisplaying: class {
    func show(checklists components: [Component<ChecklistDisplaying>])
}

public final class ListChecklistComponent: Component<ListChecklistDisplaying> {
    let presenter: ListChecklistPresenter
    
    public init(items: [Checklist]) {
        presenter = ListChecklistPresenter(items: items)
    }
    
    public override func attach(_ content: ListChecklistDisplaying) {
        presenter.view = content
        presenter.didLoadView()
    }
    
    public override func detach() {
        presenter.view = nil
    }
}
