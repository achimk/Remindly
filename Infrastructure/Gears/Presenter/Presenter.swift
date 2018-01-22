//
//  Presenter.swift
//  Gears
//
//  Created by Joachim Kret on 22.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

open class Presenter<T>: PresenterType {
    public typealias ContentType = T
    
    public init() { }
    
    open func present(_ content: T) {
        abstractMethod()
    }
    
    open func dismiss() {
    }
}
