//
//  NavigationFactory.swift
//  Remindly
//
//  Created by Joachim Kret on 26.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

struct NavigationFactory {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeRouter() -> RouterType {
        let stack = StackPresenter(navigationController: navigationController)
        let router = ProxyRouter()
        let coordinator = FlowCoordinator(stack)
        
        let listChecklistRoute = ListChecklistRoute(coordinator: coordinator, router: router)
        
        let createChecklistRoute = CreateChecklistRoute(coordinator: coordinator, router: router)
        
        let routes: [RouteType] = [
            listChecklistRoute,
            createChecklistRoute
        ]
        
        let concrete = Router(routes)
        router.proxy = concrete
        
        return concrete
    }
}

extension NavigationFactory {
    final class ProxyRouter: RouterType {
        weak var proxy: Router?
        
        func navigate(to location: Location) {
            proxy?.navigate(to: location)
        }
    }
}


