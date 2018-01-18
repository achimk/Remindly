//
//  CreateChecklistPresenter.swift
//  ChecklistsFeature
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol CreateChecklistEventListening {

}

final class CreateChecklistPresenter: CreateChecklistEventListening {
    weak var view: CreateChecklistViewable?
    
}
