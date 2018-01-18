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

final class ListChecklistViewController: UITableViewController {
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
