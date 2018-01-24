//
//  DataSourceType.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol DataSourceType {
    associatedtype Element
    func numberOfSections() -> Int
    func numberOfItems(at section: Int) -> Int
    func item(at indexPath: IndexPath) -> Element
}
