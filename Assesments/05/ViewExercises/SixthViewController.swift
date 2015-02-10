//
//  SixthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class SixthViewController: ExerciseViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let tableArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 6"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.exerciseView.addSubview(tableView)
        self.tableView.frame = self.exerciseView.frame
        self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController!.navigationBar.frame), 0, 0, 0)
        self.tableView.autoresizingMask = self.exerciseView.autoresizingMask
        self.view.addSubview(tableView)
        

        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
            ?? UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        
        /* TODO:
        The table view cells on this screen are blank.
        
        Add a label to each cell that is green and centered, and have its text say “Row {X}” (X is the row number of the cell). The tableview should rotate correctly. Use Autolayout.
        */
        
        // remove Cell subview before adding view to prevent overlap
        
        // TODO: Separator disappears after scrolling.  Only started after adding label subview
        var subViews = cell.subviews
        for view in subViews {
            view.removeFromSuperview()
        }
        
        let cellLabel = UILabel()
        cellLabel.textAlignment = NSTextAlignment.Center
        cellLabel.textColor = UIColor.greenColor()
        cellLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cellLabel.text = "Row \(tableArray[indexPath.row])"
        cell.addSubview(cellLabel)
        
        cell.addConstraint(NSLayoutConstraint(item: cellLabel, attribute: .Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: CGRectGetHeight(cell.frame)))
        cell.addConstraint(NSLayoutConstraint(item: cellLabel, attribute: .Top, relatedBy: .Equal, toItem: cell, attribute: .Top, multiplier: 1.0, constant: 0.0))
        cell.addConstraint(NSLayoutConstraint(item: cellLabel, attribute: .Left, relatedBy: .Equal, toItem: cell, attribute: .Left, multiplier: 1.0, constant: 0.0))
        cell.addConstraint(NSLayoutConstraint(item: cellLabel, attribute: .Right, relatedBy: .Equal, toItem: cell, attribute: .Right, multiplier: 1.0, constant: 0.0))
        
        cell.layoutIfNeeded()
    
        return cell
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
}
