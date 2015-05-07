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
    private let arr = ["Rectangles", "Alpha", "Line", "Ratings"]
    
    // New View Controller
    private var secondVC: SecondViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Initialize the vc
        secondVC = SecondViewController()
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
        
        self.navigationController?.pushViewController(secondVC, animated: false)

        let width = CGRectGetWidth(view.bounds)
        let height = CGRectGetHeight(view.bounds)
        
        let frame = CGRectMake(0, 0, width, height)
        
        switch indexPath.row {
        case 0:
            secondVC.sj_view = SJRectangleView(frame: frame)
        case 1:
            secondVC.sj_view = SJAlphaRectangle(frame: frame)
        case 2:
            secondVC.sj_view = SJLine(frame: frame)
        case 3:
            secondVC.sj_view = SJRatingView(frame: CGRectMake(100, 100, 200, 40))
        default:
            return
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


class SecondViewController: UIViewController {
    
    var sj_view: UIView? {
        didSet{
            deleteSubViews()
            view.addSubview(sj_view!)
        }
    }
    
    private func deleteSubViews() {
        for v in view.subviews {
            v.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


