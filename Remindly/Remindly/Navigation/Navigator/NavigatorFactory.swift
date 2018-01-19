//
//  NavigatorFactory.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

struct NavigatorFactory {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeNavigator() -> NavigatorType {
        let proxy = Proxy()
        
        let listChecklistRoute = ListChecklistRoute(navigator: proxy)
        
        let createChecklistRoute = CreateChecklistRoute(navigator: proxy)
        
        let routes: [Routable] = [
            listChecklistRoute,
            createChecklistRoute
        ]
        
        let stack = StackPresenter(navigationController: navigationController)
        let navigator = Navigator(routes: routes, presenter: stack)
        proxy.source = navigator
        
        return proxy
    }
}

extension NavigatorFactory {
    private final class Proxy: NavigatorType {
        var source: NavigatorType?
        
        func open(location: Location, using presenter: ViewPresenter?) {
            source?.open(location: location, using: presenter)
        }
    }
}
