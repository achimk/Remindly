//
//  CombinedDataSource.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class CombinedDataSource<T>: DataSource<T> {
    public var list: [DataSource<Element>]
    
    public init(_ dataSource: DataSource<Element>) {
        self.list = [dataSource]
    }
    
    public init(_ list: [DataSource<Element>] = []) {
        self.list = list
    }
    
    public override func numberOfSections() -> Int {
        return list.reduce(0, {
            return $0 + $1.numberOfSections()
        })
    }
    
    public override func numberOfItems(at section: Int) -> Int {
        guard let result = dataSource(at: section) else { return 0 }
        return result.dataSource.numberOfItems(at: result.index)
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        guard let result = dataSource(at: indexPath) else { fatalError("Invalid index path: \(indexPath)") }
        return result.dataSource.item(at: result.indexPath)
    }
    
    private func dataSource(at section: Int) -> (dataSource: DataSource<Element>, index: Int)? {
        guard section >= 0 else { return nil }
        var offset = 0
        for dimension in list {
            let sectionsCount = dimension.numberOfSections()
            if section >= offset && section < offset + sectionsCount {
                return (dimension, (section - offset))
            }
            offset += sectionsCount
        }
        return nil
        
    }
    
    private func dataSource(at indexPath: IndexPath) -> (dataSource: DataSource<Element>, indexPath: IndexPath)? {
        guard indexPath.item >= 0 else { return nil }
        if let info = dataSource(at: indexPath.section) {
            let count = info.dataSource.numberOfItems(at: info.index)
            if indexPath.item < count {
                return (info.dataSource, IndexPath(item: indexPath.item, section: info.index))
            }
        }
        return nil
    }
}
