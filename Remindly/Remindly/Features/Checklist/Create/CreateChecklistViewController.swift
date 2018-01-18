//
//  CreateChecklistViewController.swift
//  Remindly
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit
import ChecklistsFeature

final class CreateChecklistNavigationBar: CreateChecklistBarViewable {
    var eventListener: CreateChecklistBarEventListening?
    let navigationItem: UINavigationItem
    
    init(navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(CreateChecklistNavigationBar.onCreateChecklistCancel)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(CreateChecklistNavigationBar.onCreateChecklistSave)
        )
    }
    
    
    func show(title: String) {
        navigationItem.title = title
    }
    
    @objc func onCreateChecklistCancel() {
        eventListener?.didSelectCancel()
    }
    
    @objc func onCreateChecklistSave() {
        eventListener?.didSelectSave()
    }
}

final class CreateChecklistViewController: UITableViewController {
    
    lazy var navigationBar: CreateChecklistNavigationBar = {
        return CreateChecklistNavigationBar(navigationItem: self.navigationItem)
    }()
    
}

extension CreateChecklistViewController: CreateChecklistViewable {
    
    
}
