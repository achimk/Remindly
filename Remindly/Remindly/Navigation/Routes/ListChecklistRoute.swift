//
//  ListChecklistRoute.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Reminders

final class ListChecklistRoute: RouteType {
    let coordinator: FlowCoordinatorType
    let router: RouterType
    
    init(coordinator: FlowCoordinatorType, router: RouterType) {
        self.coordinator = coordinator
        self.router = router
    }
    
    func show(_ location: Location) {
        guard case Location.listChecklist = location else { return }
        
        let items: [Checklist] = [
            Checklist(identifier: "1", name: "Checklist 1", timestamp: Date(), reminders: []),
            Checklist(identifier: "2", name: "Checklist 2", timestamp: Date(), reminders: []),
            Checklist(identifier: "3", name: "Checklist 3", timestamp: Date(), reminders: []),
            Checklist(identifier: "4", name: "Checklist 4", timestamp: Date(), reminders: []),
            Checklist(identifier: "5", name: "Checklist 5", timestamp: Date(), reminders: []),
            Checklist(identifier: "6", name: "Checklist 6", timestamp: Date(), reminders: []),
            Checklist(identifier: "7", name: "Checklist 7", timestamp: Date(), reminders: [])
        ]
        
        let flow = ListChecklistFlow(router: router, items: items)
        coordinator.open(flow)
    }
}
