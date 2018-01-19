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
        let listChecklistRoute = ListChecklistRoute(navigator: proxy, navigationController: navigationController)
        let createChecklistRoute = CreateChecklistRoute(navigator: proxy, navigationController: navigationController)
        let routes: [Routable] = [
            listChecklistRoute,
            createChecklistRoute
        ]
        
        let navigator = Navigator(routes: routes)
        proxy.source = navigator
        
        return proxy
    }
}

extension NavigatorFactory {
    private final class Proxy: NavigatorType {
        var source: NavigatorType?
        
        func open(_ location: Location) {
            source?.open(location)
        }
    }
}
