//
//  Navigator.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class Navigator: NavigatorType {
    let routes: [Routable]
    
    init(routes: [Routable]) {
        self.routes = routes
    }
    
    func open(_ location: Location) {
        for route in routes {
            try! route.navigate(to: location)
        }
    }
}
