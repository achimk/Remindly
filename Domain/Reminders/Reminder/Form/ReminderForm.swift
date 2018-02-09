//
//  ReminderForm.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreDomain

public typealias ReminderFormID = Identity<ReminderForm.ID>

public final class ReminderForm: AggregateRootType {
    
    enum Status: Int {
        case new
        case created
        case modified
        case confirmed
    }
    
    public let identifier: String
    var label: String?
    var notes: String?
    var timestamp: Date = Date()
    var isAchieved: Bool = false
    var priority: Priority?
    var status: Status = .new
    
    public init(identifier: String) {
        self.identifier = identifier
        self.status = .created
    }
    
    public init(identifier: String,
                label: String,
                notes: String?,
                timestamp: Date,
                isAchieved: Bool,
                priority: Priority) {
        
        self.identifier = identifier
        self.label = label
        self.notes = notes
        self.timestamp = timestamp
        self.isAchieved = isAchieved
        self.priority = priority
        self.status = .modified
    }
    
    public func fill(label: String) throws {
        self.label = label
    }
    
    public func fill(notes: String) throws {
        self.notes = notes
    }
    
    public func confirm() throws {
        
        self.timestamp = Date()
        self.status = .confirmed
    }
    
    public func isConfirmed() -> Bool {
        return status == .confirmed
    }
    
    private func modifyFormField(_ action: (() -> Void)) throws {
        if status == .new {
            throw ReminderFormError.formNotCreated
        }
        action()
        status = .modified
    }
}
