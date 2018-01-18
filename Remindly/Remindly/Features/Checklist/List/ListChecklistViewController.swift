//
//  ListChecklistViewController.swift
//  Remindly
//
//  Created by Joachim Kret on 18.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import UIKit
import ChecklistsFeature
import Reminders

final class ListChecklistNavigationBar: ListChecklistBarViewable {
    var eventListener: ListChecklistBarEventListening?
    let navigationItem: UINavigationItem
    
    init(navigationItem: UINavigationItem) {
        self.navigationItem = navigationItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(ListChecklistNavigationBar.onCreateChecklistSelected)
        )
    }
    
    func show(title: String) {
        navigationItem.title = title
    }
    
    @objc func onCreateChecklistSelected() {
        eventListener?.didSelectCreateChecklist()
    }
}

final class ListChecklistViewController: UITableViewController {
    
    lazy var navigationBar: ListChecklistNavigationBar = {
        return ListChecklistNavigationBar(navigationItem: self.navigationItem)
    }()
    
    private var items: [Checklist] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "checklist")
        
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
    }
}

extension ListChecklistViewController: ListChecklistViewable {
    
    func show(checklists items: [Checklist]) {
        self.items = items
        tableView.reloadData()
    }
}
