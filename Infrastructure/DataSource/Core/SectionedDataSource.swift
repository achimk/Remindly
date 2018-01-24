//
//  SectionedDataSource.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class SectionedDataSource<T>: DataSource<T> {
    public var list: [DataSource<Element>]
    
    public var count: Int {
        var count = 0
        for dataSource in list {
            for section in 0 ..< dataSource.numberOfSections() {
                count = count + dataSource.numberOfItems(at: section)
            }
        }
        return count
    }
    
    public init(_ dataSource: DataSource<Element>) {
        self.list = [dataSource]
    }
    
    public init(_ list: [DataSource<Element>] = []) {
        self.list = list
    }
    
    public override func numberOfSections() -> Int {
        return count > 0 ? 1 : 0
    }
    
    public override func numberOfItems(at section: Int) -> Int {
        return section == 0 ? count : 0
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        guard let result = dataSource(at: indexPath) else { fatalError("Invalid index path: \(indexPath)") }
        return result.dataSource.item(at: result.indexPath)
    }
    
    private func dataSource(at indexPath: IndexPath) -> (dataSource: DataSource<Element>, indexPath: IndexPath)? {
        guard indexPath.section == 0 else { return nil }
        
        var offset: Int = 0
        for dataSource in list {
            for section in 0 ..< dataSource.numberOfSections() {
                for row in 0 ..< dataSource.numberOfItems(at: section) {
                    if offset == indexPath.item {
                        let localIndexPath = IndexPath(row: row, section: section)
                        return (dataSource, localIndexPath)
                    }
                    offset = (offset + 1)
                }
            }
        }
        
        return nil
    }
}
