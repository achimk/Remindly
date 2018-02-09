//
//  Checklist.swift
//  Reminders
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreDomain

public struct Checklist: EntityType {
    public let identifier: String
    public let name: String
    public let timestamp: Date
    public let reminders: [Reminder]
    
    public init(identifier: String,
                name: String,
                timestamp: Date,
                reminders: [Reminder]) {
        
        self.identifier = identifier
        self.name = name
        self.timestamp = timestamp
        self.reminders = reminders
    }
}

extension Checklist: Equatable {
    
    public static func == (lhs: Checklist, rhs: Checklist) -> Bool {
        return lhs.identifier == rhs.identifier
            && lhs.name == rhs.name
            && lhs.timestamp == rhs.timestamp
            && lhs.reminders == rhs.reminders
    }
}
