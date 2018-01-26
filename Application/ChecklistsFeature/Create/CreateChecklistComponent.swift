//
//  CreateChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreApp

public enum CreateForm {
    case name
}

public protocol CreateChecklistDisplaying: class {
//    func show(form: [CreateForm])
}

public final class CreateChecklistComponent: Component<CreateChecklistDisplaying> {
    let presenter = CreateChecklistPresenter()
    
    public override func attach(_ content: CreateChecklistDisplaying) {
        presenter.view = content
        presenter.viewDidLoad()
    }
    
    public override func detach() {
        presenter.view = nil
    }
}
