//
//  TableViewCells.swift
//  ReusableViews
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit

public final class DefaultTableViewCell: UITableViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
}

public final class SubtitleTableViewCell: UITableViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

public final class ValueTableViewCell: UITableViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
}

public final class ValueAltTableViewCell: UITableViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
}
