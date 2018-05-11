//
//  ReminderFormFillLabelUseCase.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ReminderFormFillLabelUseCase {
    let identifier: ReminderFormID
    let repository: ReminderFormRepository
    let label: String
    
    init(identifier: ReminderFormID, repository: ReminderFormRepository, label: String) {
        self.identifier = identifier
        self.repository = repository
        self.label = label
    }
    
    func execute() throws {
        
        guard let form = repository.findBy(identifier) else {
            throw ReminderFormError.formNotFound
        }
        
        try form.fill(label: label)

        repository.save(id: identifier, entity: form)
    }
}
