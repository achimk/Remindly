//
//  ProxyPresenter.swift
//  CoreApp
//
//  Created by Joachim Kret on 22.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class ProxyPresenter<T>: Presenter<T> {
    public var source: Presenter<T>?
    
    public init(_ source: Presenter<T>? = nil) {
        self.source = source
    }
    
    public override func present(_ content: ContentType) {
        source?.present(content)
    }
    
    public override func dismiss() {
        source?.dismiss()
    }
}
