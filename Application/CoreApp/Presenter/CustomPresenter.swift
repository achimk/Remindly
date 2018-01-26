//
//  CustomPresenter.swift
//  CoreApp
//
//  Created by Joachim Kret on 22.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class CustomPresenter<T>: Presenter<T> {
    public var onPresent: ((ContentType) -> Void)?
    public var onDismiss: (() -> Void)?
    
    public override func present(_ content: ContentType) {
        onPresent?(content)
    }
    
    public override func dismiss() {
        onDismiss?()
    }
}
