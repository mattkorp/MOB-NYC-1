//
//  TableViewController.swift
//  ArrayExercise
//
//  Created by trvslhlt on 1/19/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  var cities = ["Boston", "Chicago", "Atlanta", "Dallas"]
  let cellReuseID = "cell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
  }
  
  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as UITableViewCell
    cell.textLabel.text = cities[indexPath.row]
    return cell
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      cities.removeAtIndex(indexPath.row)
      tableView.reloadData()
    }
  }
  
  // MARK: IBActions
  @IBAction func addTapped(sender: AnyObject) {
    let alert = UIAlertController(title: "Cities", message: "Add a new city", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addTextFieldWithConfigurationHandler({ textField in
      textField.placeholder = "..."
      return
    })
    
    let cancel = UIAlertAction(title: "nevermind", style: UIAlertActionStyle.Cancel, handler: nil)
    let add = UIAlertAction(title: "done", style: UIAlertActionStyle.Default, handler: { action in
      let textFields = alert.textFields
      if let tf = textFields as? [UITextField] {
        let cityInput = tf[0].text
        self.cities += [cityInput]
        self.tableView.reloadData()
      }
    })
    
    alert.addAction(cancel)
    alert.addAction(add)
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  @IBAction func sortTapped(sender: AnyObject) {
    cities = sorted(cities, <)
    tableView.reloadData()
  }
}

















