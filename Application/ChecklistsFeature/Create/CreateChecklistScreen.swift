//
//  CreateChecklistScreen.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreApp

public final class CreateChecklistScreen {
    public let navigationBarComponent: Component<CreateChecklistBarDisplaying>
    public let formComponent: Component<CreateChecklistDisplaying>
    
    public init(navigationBarComponent: Component<CreateChecklistBarDisplaying>,
                formComponent: Component<CreateChecklistDisplaying>) {
        
        self.navigationBarComponent = navigationBarComponent
        self.formComponent = formComponent
    }
}
