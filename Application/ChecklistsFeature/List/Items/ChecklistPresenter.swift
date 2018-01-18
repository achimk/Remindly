//
//  ChecklistPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Reminders

public protocol ChecklistEventListening {
    func didSelect()
}

final class ChecklistPresenter: ChecklistEventListening {
    let item: Checklist
    weak var view: ChecklistViewable?
    
    init(item: Checklist) {
        self.item = item
    }
    
    func didSelect() {
        view?.showSelected(checklist: item)
    }
}
