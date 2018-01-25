//
//  PureConstructible.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol PureConstructible: TypeConstructor {
    static func pure(_ value: ParameterType) -> Self
}
