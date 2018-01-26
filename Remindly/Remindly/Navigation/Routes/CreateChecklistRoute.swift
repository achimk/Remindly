//
//  CreateChecklistRoute.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

final class CreateChecklistRoute: Routable {
    let router: RouterType
    
    init(router: RouterType) {
        self.router = router
    }
    
    func navigate(to location: Location, using screen: ScreenPresenter) throws {
        guard case Location.createChecklist = location else { return }
        
        let flow = CreateChecklistFlow()
        screen.present(flow)
    }
}
