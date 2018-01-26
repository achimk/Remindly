//
//  CreateChecklistRoute.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

final class CreateChecklistRoute: RouteType {
    let coordinator: FlowCoordinatorType
    let router: RouterType
    
    init(coordinator: FlowCoordinatorType, router: RouterType) {
        self.coordinator = coordinator
        self.router = router
    }
    
    func show(_ location: Location) {
        guard case Location.createChecklist = location else { return }
        
        let flow = CreateChecklistFlow()
        coordinator.open(flow)
    }
}
