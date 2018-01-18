//
//  CreateChecklistScreen.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public final class CreateChecklistScreen {
    public let navigationBarComponent: Component<CreateChecklistBarViewable>
    public let formComponent: Component<CreateChecklistViewable>
    
    public init(navigationBarComponent: Component<CreateChecklistBarViewable>,
                formComponent: Component<CreateChecklistViewable>) {
        
        self.navigationBarComponent = navigationBarComponent
        self.formComponent = formComponent
    }
}
