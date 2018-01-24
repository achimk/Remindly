//
//  CollectionDataSource.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class CollectionDataSource<C: Collection>: DataSource<C.Element> where C.Index == Int, C.IndexDistance == Int {
    public let collection: C
    
    public init(_ collection: C) {
        self.collection = collection
    }
    
    public override func numberOfSections() -> Int {
        return collection.count > 0 ? 1 : 0
    }
    
    public override func numberOfItems(at section: Int) -> Int {
        return section == 0 ? collection.count : 0
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        return collection[indexPath.item]
    }
}
