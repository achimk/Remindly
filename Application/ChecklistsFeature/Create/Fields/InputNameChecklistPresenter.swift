//
//  InputNameChecklistPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol InputNameChecklistEventListening {
    func didLoadView()
    func didChange(name: String?)
}

final class InputNameChecklistPresenter: InputNameChecklistEventListening {
    let placeholder = "Name"
    var value: String?
    
    weak var view: InputNameChecklistDisplaying?
    
    func didLoadView() {
        view?.setup(with: placeholder, value: value)
    }
    
    func didChange(name: String?) {
        value = name
    }
}
