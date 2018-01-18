//
//  InputNameChecklistPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol InputNameChecklistEventListening {
    func didChange(name: String)
}

final class InputNameChecklistPresenter: InputNameChecklistEventListening {

    weak var view: InputNameChecklistViewable?
    
    func didChange(name: String) {
        
    }
}
