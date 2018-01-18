//
//  ListChecklistPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import Reminders

protocol ListChecklistEventListening {
    func didLoadView()
}

final class ListChecklistPresenter: ListChecklistEventListening {
    var items: [Checklist]
    weak var view: ListChecklistViewable?
    
    init(items: [Checklist]) {
        self.items = items
    }
    
    func didLoadView() {
        view?.show(checklists: items)
    }
}
