//
//  ProxyPresenter.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ProxyPresenter<T>: Presenter<T> {
    var source: Presenter<T>?
    
    init(_ source: Presenter<T>? = nil) { self.source = source }
    
    override func present(_ content: ContentType) {
        source?.present(content)
    }
    
    override func dismiss() {
        source?.dismiss()
    }
}
