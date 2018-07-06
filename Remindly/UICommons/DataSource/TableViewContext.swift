//
//  Created by Joachim Kret on 13.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

public final class TableViewContext {
    
    private var cellsRegistry: [String] = []
    private let tableView: UITableView
    
    public init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    public func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable & NibLoadable {

        if !cellsRegistry.contains(cellType.reuseIdentifier) {
            cellsRegistry.append(cellType.reuseIdentifier)
            tableView.register(cellType: cellType)
        }
    }
    
    public func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {

        if !cellsRegistry.contains(cellType.reuseIdentifier) {
            cellsRegistry.append(cellType.reuseIdentifier)
            tableView.register(cellType: cellType)
        }
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        
        return tableView.dequeueReusableCell(for: indexPath, cellType: cellType)
    }
}
