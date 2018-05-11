//
//  ReminderFormError.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public enum ReminderFormError: Swift.Error {
    case formNotFound
    case formNotCreated
    case form(validation: Swift.Error)
    case unknown(Swift.Error)
}
