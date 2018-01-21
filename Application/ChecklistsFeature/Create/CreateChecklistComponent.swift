//
//  CreateChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public enum CreateForm {
    case name
}

public protocol CreateChecklistViewable: class {
//    func show(form: [CreateForm])
}

public final class CreateChecklistComponent: Component<CreateChecklistViewable> {
    let presenter = CreateChecklistPresenter()
    
    public override func attach(_ content: CreateChecklistViewable) {
        presenter.view = content
        presenter.viewDidLoad()
    }
    
    public override func detach() {
        presenter.view = nil
    }
}
