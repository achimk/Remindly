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
    let isAchieved: Bool = false
    var priority: Priority?
    var status: Status = .new
    
    public init(identifier: String) {
        self.identifier = identifier
        self.status = .created
    }
    
    public init(identifier: String,
                label: String,
                notes: String?,
                priority: Priority) {
        
        self.identifier = identifier
        self.label = label
        self.notes = notes
        self.priority = priority
        self.status = .modified
    }
    
    public func fill(label: String) throws {
        try modifyFormField {
            self.label = label
        }
    }
    
    public func fill(notes: String) throws {
        try modifyFormField {
            self.notes = notes
        }
    }
    
    public func fill(priority: Priority) throws {
        try modifyFormField {
            self.priority = priority
        }
    }
    
    public func confirm() throws {
        
        // TODO: Validate!
        
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
