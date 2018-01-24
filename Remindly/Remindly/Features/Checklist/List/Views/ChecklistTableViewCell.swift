//
//  ChecklistTableViewCell.swift
//  Remindly
//
//  Created by Joachim Kret on 21.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit
import ChecklistsFeature
import Reminders

final class ChecklistTableViewCell: UITableViewCell, ChecklistDisplaying {
    
    func setup(with checklist: Checklist) {
        textLabel?.text = checklist.name
    }
}
