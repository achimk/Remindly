//
//  Priority.swift
//  Reminders
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import CoreDomain

public enum Priority: Int, ValueObjectType {
    case low
    case high
    case urgent
}
