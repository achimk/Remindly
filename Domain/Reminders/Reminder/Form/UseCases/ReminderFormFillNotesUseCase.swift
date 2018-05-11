//
//  ReminderFormFillNotesUseCase.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ReminderFormFillNotesUseCase {
    let identifier: ReminderFormID
    let repository: ReminderFormRepository
    let notes: String
    
    init(identifier: ReminderFormID, repository: ReminderFormRepository, notes: String) {
        self.identifier = identifier
        self.repository = repository
        self.notes = notes
    }
    
    func execute() throws {
        
        guard let form = repository.findBy(identifier) else {
            throw ReminderFormError.formNotFound
        }
        
        try form.fill(notes: notes)
        
        repository.save(id: identifier, entity: form)
    }
}
