//
//  ReminderFormRepository.swift
//  Reminders
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreDomain

public protocol ReminderFormRepository: DomainRepositoryType {
    func load(_ id: ReminderFormID) -> ReminderForm?
    func save(_ form: ReminderForm)
}
