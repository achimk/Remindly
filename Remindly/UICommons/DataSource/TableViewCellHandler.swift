//
//  Created by Joachim Kret on 14.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

public protocol TableViewCellHandling {
    
    func didSelectCell(at indexPath: IndexPath)
    
    func willBeginDisplayCell(at indexPath: IndexPath)
    
    func didEndDisplayCell(at indexPath: IndexPath)
    
    func dequeueCell(at indexPath: IndexPath) -> UITableViewCell
    
    func heightOfCell(at indexPath: IndexPath) -> CGFloat
}

public final class TableViewCellHandler: TableViewCellHandling {
    
    public var onSelectCell: ((IndexPath) -> Void)?
    public var onWillBeginDisplayCell: ((IndexPath) -> Void)?
    public var onDidEndDisplayCell: ((IndexPath) -> Void)?
    public var onHeightCell: ((IndexPath) -> CGFloat)?
    public let onDequeueCell: ((IndexPath) -> UITableViewCell)
    
    public init(onDequeueCell: @escaping ((IndexPath) -> UITableViewCell)) {
        self.onDequeueCell = onDequeueCell
    }
    
    public func didSelectCell(at indexPath: IndexPath) {
        onSelectCell?(indexPath)
    }
    
    public func willBeginDisplayCell(at indexPath: IndexPath) {
        onWillBeginDisplayCell?(indexPath)
    }
    
    public func didEndDisplayCell(at indexPath: IndexPath) {
        onDidEndDisplayCell?(indexPath)
    }
    
    public func dequeueCell(at indexPath: IndexPath) -> UITableViewCell {
        return onDequeueCell(indexPath)
    }
    
    public func heightOfCell(at indexPath: IndexPath) -> CGFloat {
        return onHeightCell?(indexPath) ?? UITableViewAutomaticDimension
    }
}
