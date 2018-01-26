//
//  PresenterType.swift
//  CoreApp
//
//  Created by Joachim Kret on 22.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol Presenting {
    associatedtype ContentType
    func present(_ content: ContentType)
}

extension Presenting where ContentType == Void {
    public func present() { self.present(()) }
}

public protocol Dismissing {
    func dismiss()
}

public protocol PresenterType: Presenting, Dismissing { }
