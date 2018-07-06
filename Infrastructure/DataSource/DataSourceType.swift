//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol DataSourceType {
    
    associatedtype Element
    
    var isEmpty: Bool { get }
    
    func numberOfSections() -> Int
    
    func numberOfItemsInSection(_ section: Int) -> Int
    
    func item(at indexPath: IndexPath) -> Element
}
