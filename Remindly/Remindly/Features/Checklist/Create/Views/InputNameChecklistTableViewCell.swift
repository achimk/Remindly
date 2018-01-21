//
//  InputNameChecklistTableViewCell.swift
//  Remindly
//
//  Created by Joachim Kret on 21.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation
import ChecklistsFeature

final class InputNameChecklistTableViewCell: UITableViewCell, InputNameChecklistViewable {
    let textField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textField.frame = UIEdgeInsetsInsetRect(contentView.bounds, insets)
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(textField)
    }
    
    func setup(with placeholder: String, value: String?) {
        textField.placeholder = placeholder
        textField.text = value
    }
}
