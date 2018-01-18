//
//  CreateChecklistBarPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol CreateChecklistBarEventListening {
    func didLoadView()
    func didSelectCancel()
    func didSelectSave()
}

final class CreateChecklistBarPresenter: CreateChecklistBarEventListening {
    let onSelectCancel: (() -> Void)?
    let onSelectSave: (() -> Void)?
    weak var view: CreateChecklistBarViewable?
    
    init(onSelectCancel: (() -> Void)?,
         onSelectSave: (() -> Void)?) {
        
        self.onSelectCancel = onSelectCancel
        self.onSelectSave = onSelectSave
    }
    
    func didLoadView() {
        view?.show(title: "Create")
    }
    
    func didSelectCancel() {
        onSelectCancel?()
    }
    
    func didSelectSave() {
        onSelectSave?()
    }
}
