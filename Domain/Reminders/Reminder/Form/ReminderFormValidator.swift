//
//  ReminderFormValidator.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ReminderFormValidator {
    
    func isValid(label: String?) -> Bool {
        fatalError()
    }
 
    func isValid(notes: String?) -> Bool {
        fatalError()
    }
    
    func isValid(priority: Priority?) -> Bool {
        fatalError()
    }
    
    func isValid(form: ReminderForm) -> Bool {
        return isValid(label: form.label)
            && isValid(notes: form.notes)
            && isValid(priority: form.priority)
    }
}
