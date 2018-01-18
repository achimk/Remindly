//
//  InputNameChecklistComponent.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public protocol InputNameChecklistViewable: class {
    func showValidInput()
    func showInvalidInput()
}

public final class InputNameChecklistComponent: Component<InputNameChecklistViewable> {
    let presenter = InputNameChecklistPresenter()
    
    public override func attach(_ content: InputNameChecklistViewable) {
        
    }
    
    public override func detach() {
        
    }
}
