//
//  PresenterTypes.swift
//  Remindly
//
//  Created by Joachim Kret on 19.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit
import CoreApp

typealias ViewPresenter = Presenter<UIViewController>
typealias FlowPresenter = Presenter<ViewPresenter>
typealias ScreenPresenter = Presenter<FlowPresenter>
