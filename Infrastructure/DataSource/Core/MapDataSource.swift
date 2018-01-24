//
//  MapDataSource.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class MapDataSource<S, R>: DataSource<R> {
    public let source: DataSource<S>
    public let resultSelector: ((S) -> R)
    
    public init(source: DataSource<S>, resultSelector: @escaping ((S) -> R)) {
        self.source = source
        self.resultSelector = resultSelector
    }
    
    public override func numberOfSections() -> Int {
        return source.numberOfSections()
    }
    
    public override func numberOfItems(at section: Int) -> Int {
        return source.numberOfItems(at: section)
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        return resultSelector(source.item(at: indexPath))
    }
}
