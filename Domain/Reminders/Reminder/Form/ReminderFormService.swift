//
//  ReminderFormService.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreDomain
import Functional

public final class ReminderFormService: DomainServiceType {
    public typealias Result = Functional.Result<ReminderFormID, ReminderFormError>
    
    public func createForm() -> Result {
        fatalError()
    }
    
    public func fill(label: String, for formID: ReminderFormID) -> Result {
        fatalError()
    }
    
    public func fill(notes: String, for formID: ReminderFormID) -> Result {
        fatalError()
    }
    
    public func fill(priority: Priority, for formID: ReminderFormID) -> Result {
        fatalError()
    }
    
    public func confirmForm() -> Result {
        fatalError()
    }
    
}
