//
//  ReminderFormCreateUseCase.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ReminderFormCreateUseCase {
    let identifier: ReminderFormID
    let repository: ReminderFormRepository
    
    init(identifier: ReminderFormID, repository: ReminderFormRepository) {
        self.identifier = identifier
        self.repository = repository
    }
    
    func execute() throws {
        let form = ReminderForm(identifier: identifier.rawValue)
        repository.save(id: identifier, entity: form)
    }
}
