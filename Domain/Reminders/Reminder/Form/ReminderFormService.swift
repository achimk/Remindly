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

public typealias ReminderFormResult = Functional.Result<ReminderFormID, ReminderFormError>

public final class ReminderFormService: DomainServiceType {
    let reminderFormRepository: ReminderFormRepository
    
    public init(reminderFormRepository: ReminderFormRepository) {
        self.reminderFormRepository = reminderFormRepository
    }
    
    public func createForm() -> ReminderFormResult {
        
        let formID = ReminderFormID(UUID().uuidString)
        let useCase = ReminderFormCreateUseCase(
            identifier: formID,
            repository: reminderFormRepository
        )
        
        return run(formID, useCase.execute)
    }
    
    public func fill(label: String, for formID: ReminderFormID) -> ReminderFormResult {
        
        let useCase = ReminderFormFillLabelUseCase(
            identifier: formID,
            repository: reminderFormRepository,
            label: label
        )
        
        return run(formID, useCase.execute)
    }
    
    public func fill(notes: String, for formID: ReminderFormID) -> ReminderFormResult {
        
        let useCase = ReminderFormFillNotesUseCase(
            identifier: formID,
            repository: reminderFormRepository,
            notes: notes
        )
        
        return run(formID, useCase.execute)
    }
    
    public func fill(priority: Priority, for formID: ReminderFormID) -> ReminderFormResult {
        
        let useCase = ReminderFormFillPriorityUseCase(
            identifier: formID,
            repository: reminderFormRepository,
            priority: priority
        )
        
        return run(formID, useCase.execute)
    }
    
    public func confirmForm(_ formID: ReminderFormID) -> ReminderFormResult {
        
        let useCase = ReminderFormConfirmUseCase(
            identifier: formID,
            repository: reminderFormRepository
        )
        
        return run(formID, useCase.execute)
    }
    
    
    private func run(_ id: ReminderFormID , _ operation: (() throws -> Void)) -> ReminderFormResult {
        do {
            try operation()
            return ReminderFormResult.success(id)
        } catch let error as ReminderFormError {
            return ReminderFormResult.failure(error)
        } catch {
            let err = ReminderFormError.unknown(error)
            return ReminderFormResult.failure(err)
        }
    }
}
