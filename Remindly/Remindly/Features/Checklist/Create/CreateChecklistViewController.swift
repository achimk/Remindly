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

final class CreateChecklistDataSource: NSObject, UITableViewDelegate, UITableViewDataSource, CreateChecklistViewable {
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InputNameChecklistTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

final class CreateChecklistViewController: UITableViewController {
    
    lazy var navigationBar: CreateChecklistNavigationBar = {
        return CreateChecklistNavigationBar(navigationItem: self.navigationItem)
    }()
    
    lazy var dataSource: CreateChecklistDataSource = {
        return CreateChecklistDataSource(tableView: self.tableView)
    }()
}

