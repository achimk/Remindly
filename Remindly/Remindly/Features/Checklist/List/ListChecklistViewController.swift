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
import Gears

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

final class ListChecklistDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, ListChecklistViewable {
    let tableView: UITableView
    private var components: [Component<ChecklistViewable>] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChecklistTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func show(checklists components: [Component<ChecklistViewable>]) {
        self.components = components
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ChecklistTableViewCell else { return }
        let component = components[indexPath.row]
        component.attach(cell)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _ = cell as? ChecklistTableViewCell else { return }
        let component = components[indexPath.row]
        component.detach()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
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
