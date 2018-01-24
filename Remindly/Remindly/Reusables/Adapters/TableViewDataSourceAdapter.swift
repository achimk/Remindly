//
//  TableViewDataSourceAdapter.swift
//  Remindly
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit
import DataSource

protocol TableViewCellHandlerType {
    func didSelectCell(in tableView: UITableView, at indexPath: IndexPath)
    func willBeginDisplayCell(in tableView: UITableView, at indexPath: IndexPath)
    func didEndDisplayCell(in tableView: UITableView, at indexPath: IndexPath)
    func dequeueCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

final class TableViewCellHandler: TableViewCellHandlerType {
    let onDequeueCell: ((UITableView, IndexPath) -> UITableViewCell)
    var onSelectCell: ((UITableView, IndexPath) -> Void)?
    var onWillBeginDisplayCell: ((UITableView, IndexPath) -> Void)?
    var onDidEndDisplayCell: ((UITableView, IndexPath) -> Void)?
    
    init(_ dequeue: @escaping ((UITableView, IndexPath) -> UITableViewCell)) {
        self.onDequeueCell = dequeue
    }

    func didSelectCell(in tableView: UITableView, at indexPath: IndexPath) {
        onSelectCell?(tableView, indexPath)
    }
    
    func willBeginDisplayCell(in tableView: UITableView, at indexPath: IndexPath) {
        onWillBeginDisplayCell?(tableView, indexPath)
    }
    
    func didEndDisplayCell(in tableView: UITableView, at indexPath: IndexPath) {
        onDidEndDisplayCell?(tableView, indexPath)
    }
    
    func dequeueCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return onDequeueCell(tableView, indexPath)
    }
}

final class TableViewDataSourceAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    var shouldAlwaysMergeDataSources: Bool = true
    private var _dataSource: DataSource<TableViewCellHandlerType>?
    var dataSource: DataSource<TableViewCellHandlerType>? {
        set { _dataSource = shouldAlwaysMergeDataSources ? newValue?.merged() : newValue }
        get { return _dataSource }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).didSelectCell(in: tableView, at: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.item(at: indexPath).dequeueCell(in: tableView, at: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).willBeginDisplayCell(in: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).didEndDisplayCell(in: tableView, at: indexPath)
    }
}
