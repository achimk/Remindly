//
//  RouterType.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol RouterType {
    func open(location: Location, using presenter: ViewPresenter?)
}

extension RouterType {
    func open(_ location: Location) {
        open(location: location, using: nil)
    }
}
