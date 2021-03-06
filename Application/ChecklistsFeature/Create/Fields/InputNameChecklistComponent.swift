//
//  InputNameChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreApp

public protocol InputNameChecklistDisplaying: class {
    func setup(with placeholder: String, value: String?)
}

public final class InputNameChecklistComponent: Component<InputNameChecklistDisplaying> {
    let presenter = InputNameChecklistPresenter()
    
    public override func attach(_ content: InputNameChecklistDisplaying) {
        presenter.view = content
        presenter.didLoadView()
    }
    
    public override func detach() {
        presenter.view = nil
    }
}
