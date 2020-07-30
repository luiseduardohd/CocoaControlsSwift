//
//  DemoTableViewController.swift
//  PullToRefreshSwift
//
//  Created by Luis Eduardo Hdz on 03/02/20.
//  Copyright © 2020 Luis Eduardo Hdz. All rights reserved.
//

import Foundation
import UIKit
//import PullRefreshTableViewController

class DemoTableViewController : PullRefreshTableViewController {

    var items: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pull to Refresh"
        items = NSMutableArray(objects: "What time is it?")
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier: String = "CellIdentifier"
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)!
        //if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        //}
        cell.textLabel!.text = items!.object(at: indexPath.row) as? String
        cell.selectionStyle = .none
        return cell
    }
    
    override func refresh() {
        self.perform(Selector(("addItem")), with: nil, afterDelay: 2.0)
    }
    
    @objc func addItem() {
        // Add a new time
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        let now: String = dateFormatter.string(from: NSDate() as Date)
        items?.insert(("\(now)"), at: 0)
        self.tableView.reloadData()
        self.stopLoading()
    }
    
    
    
}
