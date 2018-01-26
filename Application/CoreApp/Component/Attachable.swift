//
//  Attachable.swift
//  CoreApp
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol Attachable {
    associatedtype ViewType
    func attach(_ content: ViewType)
}
