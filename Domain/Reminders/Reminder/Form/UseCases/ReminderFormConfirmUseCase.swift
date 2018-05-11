//
//  ReminderFormConfirmUseCase.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ReminderFormConfirmUseCase {
    let identifier: ReminderFormID
    let repository: ReminderFormRepository
    
    init(identifier: ReminderFormID, repository: ReminderFormRepository) {
        self.identifier = identifier
        self.repository = repository
    }
    
    func execute() throws {
    
        guard let form = repository.findBy(identifier) else {
            throw ReminderFormError.formNotFound
        }
        
        try form.confirm()
        
        repository.save(id: identifier, entity: form)
    }
}
