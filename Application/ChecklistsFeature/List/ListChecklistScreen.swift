//
//  ListChecklistScreen.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Gears

public final class ListChecklistScreen {
    public let navigationBarComponent: Component<ListChecklistBarViewable>
    public let listComponent: Component<ListChecklistViewable>
    
    public init(navigationBarComponent: Component<ListChecklistBarViewable>,
                listComponent: Component<ListChecklistViewable>) {
        
        self.navigationBarComponent = navigationBarComponent
        self.listComponent = listComponent
    }
}
