//
// Created by Luis Eduardo Hdz on 18/02/20.
// Copyright (c) 2020 LEHD. All rights reserved.
//

import Foundation
import UIKit


class RootViewController : UITableViewController {

    var tableViewData: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.tableView.rowHeight = 57.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData!.count
    }


    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var CellIdentifier: String = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)!
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = tableViewData![indexPath.row].object(forKey: "title") as! String
        cell.imageView!.image = UIImage(named: tableViewData![indexPath.row].object(forKey: "image") as! String)
        return cell
    }
/*
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let classx: String = tableViewData![indexPath.row].object(forKey: "class") as! String
        var detailClass: AnyClass = NSClassFromString(classx)!
        var detailViewController: UIViewController = detailClass.init(nibName: nil, bundle: nil) as! UIViewController
        detailViewController.title = tableViewData![indexPath.row].object(forKey: "title") as! String
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    */
/*
    override func shouldAutorotate(to interfaceOrientation: UIInterfaceOrientation) -> Bool {
        return true
    }
*/


}

