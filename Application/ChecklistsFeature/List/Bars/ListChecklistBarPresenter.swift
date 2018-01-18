//
//  ListChecklistBarPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol ListChecklistBarEventListening {
    func didLoadView()
    func didSelectCreateChecklist()
}

final class ListChecklistBarPresenter: ListChecklistBarEventListening {
    let onSelectCreateChecklist: (() -> Void)?
    weak var view: ListChecklistBarViewable?
    
    init(_ onSelectCreateChecklist: (() -> Void)?) {
        self.onSelectCreateChecklist = onSelectCreateChecklist
    }
    
    func didLoadView() {
        view?.show(title: "Lists")
    }
    
    func didSelectCreateChecklist() {
        onSelectCreateChecklist?()
    }
}
