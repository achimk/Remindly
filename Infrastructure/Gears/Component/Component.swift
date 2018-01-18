//
//  Component.swift
//  Gears
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

open class Component<T>: ComponentType {
    public typealias ViewType = T
    
    public init() { }
    
    open func attach(_ content: ViewType) {
        abstractMethod()
    }
    
    open func detach() {
    }
}
