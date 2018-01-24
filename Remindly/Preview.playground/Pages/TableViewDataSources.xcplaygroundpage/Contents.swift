//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ReusableViews
import DataSource

final class MyViewController : UITableViewController {
    
    struct Data {
        let title: String
        let details: String
    }
    
    let adapter = TableViewDataSourceAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        tableView.delegate = adapter
        tableView.dataSource = adapter
        adapter.dataSource = createDataSource()
    }
    
    func registerCells() {
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "subtitle")
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "default")
        tableView.register(ValueTableViewCell.self, forCellReuseIdentifier: "value")
        tableView.register(ValueAltTableViewCell.self, forCellReuseIdentifier: "valueAlt")
    }
    
    func createDataSource() -> DataSource<TableViewCellHandlerType> {
        
        let tableView = self.tableView
        let dataSource1 = DataSource.pure(Data(title: "First title", details: "First description"))
        let dataSource2 = DataSource.of([1, 2, 3, 4, 5, 6]).map { String($0) }
        let dataSource3 = DataSource.of([("property 1", "value 1"), ("property 2", "value 2"), ("property 3", "value 3")])
        let dataSource4 = DataSource.of([("property", "123"), ("property", "456"), ("property", "789")])
        
        let cellsProvider1 = dataSource1.map { data -> TableViewCellHandlerType in
            return TableViewCellHandler { (tableView, indexPath) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "subtitle", for: indexPath)
                cell.textLabel?.text = data.title
                cell.detailTextLabel?.text = data.details
                return cell
            }
        }
        
        let cellsProvider2 = dataSource2.map { (input) -> TableViewCellHandlerType in
            return TableViewCellHandler { (tableView, indexPath) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
                cell.textLabel?.text = input
                return cell
            }
        }
        
        let cellsProvider3 = dataSource3.map { (name, value) -> TableViewCellHandlerType in
            return TableViewCellHandler { (tableView, indexPath) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "value", for: indexPath)
                cell.textLabel?.text = name
                cell.detailTextLabel?.text = value
                return cell
            }
        }
        
        let cellsProvider4 = dataSource4.map { (name, value) -> TableViewCellHandlerType in
            return TableViewCellHandler { (tableView, indexPath) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "valueAlt", for: indexPath)
                cell.textLabel?.text = name
                cell.detailTextLabel?.text = value
                return cell
            }
        }
        
        let providers: [DataSource<TableViewCellHandlerType>] = [
            cellsProvider1,
            cellsProvider2,
            cellsProvider3,
            cellsProvider4
        ]
        
        return CombinedDataSource(providers)
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController(style: .grouped)
