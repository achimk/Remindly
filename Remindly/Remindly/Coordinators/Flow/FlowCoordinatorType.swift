//
//  FlowCoordinatorType.swift
//  Remindly
//
//  Created by Joachim Kret on 26.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

typealias FlowType = FlowPresenter

protocol FlowCoordinatorType {
    func open(_ flow: FlowType)
}
