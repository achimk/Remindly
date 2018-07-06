//
//  ReminderService.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreDomain

final class ReminderService: DomainService {
    
    struct Query { }
    
    func find(reminder id: ReminderID) -> Reminder? {
        fatalError()
    }
    
    func find(reminders: Query) -> [Reminder] {
        fatalError()
    }
}
