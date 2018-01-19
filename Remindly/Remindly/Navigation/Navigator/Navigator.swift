//
//  Navigator.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class Navigator: NavigatorType {
    private var screens: [ScreenPresenter] = []
    private let routes: [Routable]
    private let presenter: ViewPresenter
    
    init(routes: [Routable], presenter: ViewPresenter) {
        self.routes = routes
        self.presenter = presenter
    }
    
    func open(location: Location, using presenter: ViewPresenter?) {
        
        for route in routes {
            do {
                let screen = FlowContainer(validPresenter(presenter))
                screen.onDismiss = { [unowned screen] in
                    self.remove(screen)
                }
                
                try route.navigate(to: location, using: screen)
                
                if screen.flow != nil {
                    screens.append(screen)
                }
            } catch {
                print("-> Error: \(error)")
            }
        }
    }
    
    private func remove(_ screen: ScreenPresenter) {
        
        let index = screens.index { (presenter) -> Bool in
            return presenter === screen
        }
        
        if let index = index {
            screens.remove(at: index)
        }
    }
    
    private func validPresenter(_ input: ViewPresenter?) -> ViewPresenter {
        return input ?? presenter
    }
}

private final class FlowContainer: ScreenPresenter {
    private(set) var flow: FlowPresenter?
    private(set) var view: ViewPresenter
    var onPresent: (() -> Void)?
    var onDismiss: (() -> Void)?
    
    init(_ view: ViewPresenter) {
        self.view = view
    }
    
    override func present(_ content: FlowPresenter) {
        flow = content
        flow?.present(view)
        onPresent?()
    }
    
    override func dismiss() {
        flow?.dismiss()
        flow = nil
        onDismiss?()
    }
}

