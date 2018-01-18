//
//  Reminder.swift
//  Reminders
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public struct Reminder {
    public let identifier: String
    public let title: String
    public let notes: String?
    public let timestamp: Date
    public let isAchieved: Bool
    public let priority: Priority
    
    
    public init(identifier: String,
                title: String,
                notes: String?,
                timestamp: Date,
                isAchieved: Bool,
                priority: Priority) {
        
        self.identifier = identifier
        self.title = title
        self.notes = notes
        self.timestamp = timestamp
        self.isAchieved = isAchieved
        self.priority = priority
    }
}

extension Reminder: Equatable {
    
    public static func == (lhs: Reminder, rhs: Reminder) -> Bool {
        return lhs.identifier == rhs.identifier
            && lhs.title == rhs.title
            && lhs.notes == rhs.notes
            && lhs.timestamp == rhs.timestamp
            && lhs.isAchieved == rhs.isAchieved
            && lhs.priority == rhs.priority
    }
}
