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
    public let navigationBarComponent: Component<ListChecklistBarDisplaying>
    public let listComponent: Component<ListChecklistDisplaying>
    
    public init(navigationBarComponent: Component<ListChecklistBarDisplaying>,
                listComponent: Component<ListChecklistDisplaying>) {
        
        self.navigationBarComponent = navigationBarComponent
        self.listComponent = listComponent
    }
}
