//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
//import DataSource

final class MyViewController : UITableViewController {
    let adapter = TableViewDataSourceAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.de
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
