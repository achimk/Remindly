//
//  ReminderFormFillPriorityUseCase.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ReminderFormFillPriorityUseCase {
    let identifier: ReminderFormID
    let repository: ReminderFormRepository
    let priority: Priority
    
    init(identifier: ReminderFormID, repository: ReminderFormRepository, priority: Priority) {
        self.identifier = identifier
        self.repository = repository
        self.priority = priority
    }
    
    func execute() throws {
        
        guard let form = repository.findBy(identifier) else {
            throw ReminderFormError.formNotFound
        }
        
        try form.fill(priority: priority)
        
        repository.save(id: identifier, entity: form)
    }
}
