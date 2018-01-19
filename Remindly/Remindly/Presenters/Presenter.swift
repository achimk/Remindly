//
//  Presenter.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol Presenting {
    associatedtype ContentType
    func present(_ content: ContentType)
}

protocol Dismissing {
    func dismiss()
}

class Presenter<T>: Presenting, Dismissing {
    typealias ContentType = T
    
    init() { }
    
    func present(_ content: ContentType) { }
    
    func dismiss() { }
}

