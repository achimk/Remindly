//
//  PlainDataSource.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class PlainDataSource<T>: DataSource<T> {
    public var sections: [[Element]]
    
    public init(_ element: Element) {
        self.sections = [[element]]
    }
    
    public init(_ section: [Element]) {
        self.sections = [section]
    }
    
    public init(_ sections: [[Element]]) {
        self.sections = sections
    }
    
    public override func numberOfSections() -> Int {
        return sections.count
    }
    
    public override func numberOfItems(at section: Int) -> Int {
        return section >= 0 && section < sections.count ? sections[section].count : 0
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        return sections[indexPath.section][indexPath.item]
    }
}
