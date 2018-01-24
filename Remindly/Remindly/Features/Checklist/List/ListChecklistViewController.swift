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
import DataSource
import Gears

final class ListChecklistNavigationBar: ListChecklistBarDisplaying {
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

final class ListChecklistDataSource: ListChecklistDisplaying {
    let tableView: UITableView
    let adapter = TableViewDataSourceAdapter()
    private var components: [Component<ChecklistDisplaying>] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(ChecklistTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func show(checklists components: [Component<ChecklistDisplaying>]) {
        self.components = components
        
        let dataSource = DataSource.of(components).map { (component) -> TableViewCellHandlerType in
            let handler = TableViewCellHandler { (tableView, indexPath) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChecklistTableViewCell
                component.attach(cell)
                return cell
            }
            
            handler.onDidEndDisplayCell = { (_, _) in component.detach() }
            handler.onSelectCell = { (_, _) in print("-> selected component!") }
            
            return handler
        }
        
        adapter.dataSource = dataSource
        tableView.reloadData()
    }
}

final class ListChecklistViewController: UITableViewController {
    
    lazy var navigationBar: ListChecklistNavigationBar = {
        return ListChecklistNavigationBar(navigationItem: self.navigationItem)
    }()
    
    lazy var dataSource: ListChecklistDataSource = {
        return ListChecklistDataSource(tableView: tableView)
    }()
}
