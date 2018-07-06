//
//  Created by Joachim Kret on 13.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation
import DataSource

public final class TableViewDataSourceAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public var dataSource: DataSource<TableViewCellHandling>?
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).didSelectCell(at: indexPath)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItemsInSection(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.item(at: indexPath).dequeueCell(at: indexPath) ?? UITableViewCell()
    }
    
    // FIXME: Sometimes there is a problem after change the dataSource in adapter - willDisplay and didEndDisplaying functions
    // gets called on inappropriate dataSource which no longer exists and cause a crash.
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).willBeginDisplayCell(at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource?.item(at: indexPath).didEndDisplayCell(at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource?.item(at: indexPath).heightOfCell(at: indexPath) ?? UITableViewAutomaticDimension
    }
}
