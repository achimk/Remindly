//
//  PresenterConfigurable.swift
//  Remindly
//
//  Created by Joachim Kret on 26.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol PresenterConfigurable {
    associatedtype PresenterType
    func using(_ presenter: PresenterType) -> Self
}
