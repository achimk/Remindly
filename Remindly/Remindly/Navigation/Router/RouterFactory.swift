//
//  RouterFactory.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

struct RouterFactory {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeRouter() -> RouterType {
        let stack = StackPresenter(navigationController: navigationController)
        let coordinator = FlowCoordinator(stack)
        let proxy = Proxy()
        
        let listChecklistRoute = ListChecklistRoute(coordinator: coordinator, router: proxy)
        
        let createChecklistRoute = CreateChecklistRoute(coordinator: coordinator, router: proxy)
        
        let routes: [Routable] = [
            listChecklistRoute,
            createChecklistRoute
        ]
        
        let navigator = Router(routes: routes, presenter: stack)
        proxy.source = navigator
        
        return proxy
    }
}

extension RouterFactory {
    private final class Proxy: RouterType {
        var source: RouterType?
        
        func open(location: Location, using presenter: ViewPresenter?) {
            source?.open(location: location, using: presenter)
        }
    }
}
