//
//  CreateChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public protocol CreateChecklistViewable: class {
    
}

public final class CreateChecklistComponent: Component<CreateChecklistViewable> {
    let presenter = CreateChecklistPresenter()
    
    public override func attach(_ content: CreateChecklistViewable) {
        presenter.view = content
    }
    
    public override func detach() {
        presenter.view = nil
    }
}
