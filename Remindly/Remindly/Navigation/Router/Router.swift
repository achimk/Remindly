//
//  Router.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class Router: RouterType {
    private var routes: [RouteType]
    
    init(_ routes: [RouteType] = []) {
        self.routes = routes
    }
    
    func navigate(to location: Location) {
        for route in routes {
            route.show(location)
        }
    }
    
    func add(route: RouteType) {
        routes.append(route)
    }
}
