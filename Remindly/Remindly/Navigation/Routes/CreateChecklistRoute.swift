//
//  CreateChecklistRoute.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

final class CreateChecklistRoute: Routable {
    let navigator: NavigatorType
    let navigationController: UINavigationController
    
    init(navigator: NavigatorType,
         navigationController: UINavigationController) {
        
        self.navigator = navigator
        self.navigationController = navigationController
    }
    
    func navigate(to location: Location) throws {
        guard case Location.createChecklist = location else { return }
        
        let stack = StackPresenter(navigationController: navigationController)
        let flow = CreateChecklistFlow()
        flow.present(stack)
    }
}
