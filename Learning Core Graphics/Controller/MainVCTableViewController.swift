//
//  MainVCTableViewController.swift
//  Learning Core Graphics
//
//  Created by Saurabh Jain on 5/6/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class MainVCTableViewController: UITableViewController {

    // Cell identifier
    private let reuse_Identifier = "Cell"
    
    // Data Source
    private let arr = ["Rectangles", "Alpha", "Line"]
    
    // New View Controller
    private var secondVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Initialize the vc
        secondVC = UIViewController()
    }
}


// MARK: - Table view data source
extension MainVCTableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuse_Identifier, forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = arr[indexPath.row]
        
        return cell
    }
}

// MARK: Table View Delegate
extension MainVCTableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            secondVC.view = SJRectangleView()
        case 1:
            secondVC.view = SJAlphaRectangle()
        case 2:
            secondVC.view = SJLine()
        default:
            return
        }
        
        self.navigationController?.pushViewController(secondVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
