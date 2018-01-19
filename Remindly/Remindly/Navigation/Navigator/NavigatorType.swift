//
//  NavigatorType.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol NavigatorType {
    func open(location: Location, using presenter: ViewPresenter?)
}

extension NavigatorType {
    func open(_ location: Location) {
        open(location: location, using: nil)
    }
}
