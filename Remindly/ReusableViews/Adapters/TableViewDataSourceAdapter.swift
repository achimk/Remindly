//
//  TableViewDataSourceAdapter.swift
//  ReusableViews
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import DataSource

public protocol TableViewCellHandlerType {
    func didSelectCell(in tableView: UITableView, at indexPath: IndexPath)
    func willBeginDisplayCell(in tableView: UITableView, at indexPath: IndexPath)
    func didEndDisplayCell(in tableView: UITableView, at indexPath: IndexPath)
    func dequeueCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

public final class TableViewCellHandler: TableViewCellHandlerType {
    public let onDequeueCell: ((UITableView, IndexPath) -> UITableViewCell)
    public var onSelectCell: ((UITableView, IndexPath) -> Void)?
    public var onWillBeginDisplayCell: ((UITableView, IndexPath) -> Void)?
    public var onDidEndDisplayCell: ((UITableView, IndexPath) -> Void)?
    
    public init(_ dequeue: @escaping ((UITableView, IndexPath) -> UITableViewCell)) {
        self.onDequeueCell = dequeue
    }
    
    public func didSelectCell(in tableView: UITableView, at indexPath: IndexPath) {
        onSelectCell?(tableView, indexPath)
    }
    
    public func willBeginDisplayCell(in tableView: UITableView, at indexPath: IndexPath) {
        onWillBeginDisplayCell?(tableView, indexPath)
    }
    
    public func didEndDisplayCell(in tableView: UITableView, at indexPath: IndexPath) {
        onDidEndDisplayCell?(tableView, indexPath)
    }
    
    public func dequeueCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return onDequeueCell(tableView, indexPath)
    }
}

public final class TableViewDataSourceAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    public var shouldAlwaysMergeDataSources: Bool = true
    private var _dataSource: DataSource<TableViewCellHandlerType>?
    public var dataSource: DataSource<TableViewCellHandlerType>? {
        set { _dataSource = shouldAlwaysMergeDataSources ? newValue?.merged() : newValue }
        get { return _dataSource }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).didSelectCell(in: tableView, at: indexPath)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(at: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.item(at: indexPath).dequeueCell(in: tableView, at: indexPath) ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).willBeginDisplayCell(in: tableView, at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).didEndDisplayCell(in: tableView, at: indexPath)
    }
}
