//
//  MapViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  @IBOutlet weak var keyTextField: UITextField!
  @IBOutlet weak var valueTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  let cellReuseId = "cell"
  var contacts = [String: String]()
  var sortedNames: [String] {
    get {
      let names = contacts.keys
      return sorted(names)
    }
  }
  let inactiveColor = UIColor(red: 0.7, green: 0.8, blue: 0.9, alpha: 1.0)
  let activeColor = UIColor(red: 0.6, green: 0.9, blue: 0.4, alpha: 1.0)
  
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.reloadData()
    registerForNotifications()
    updateStylesForKeyboardShowing(false)
    
    /*
    TODO three: Add TWO text views and a table view to this view controller, either using code or storybaord. Accept keyboard input from the two text views. When the 'return' button is pressed on the SECOND text view, add the text view data to a dictionary. The KEY in the dictionary should be the string in the first text view, the VALUE should be the second.
    TODO four: Make this class a UITableViewDelegate and UITableViewDataSource that supply this table view with cells that correspond to the values in the dictionary. Each cell should print out a unique pair of key/value that the map contains. When a new key/value is inserted, the table view should display it.
    TODO five: Make the background of the text boxes in this controller BLUE when the keyboard comes up, and RED when it goes down. Start with UIKeyboardWillShowNotification and NSNotificationCenter.
    */
  }
  
  // MARK: Setup
  func registerForNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    
    NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil, usingBlock: { notification in
      println("Example of this syntax")
    })
  }

  // MARK: Styling
  func updateStylesForKeyboardShowing(showing: Bool) {
    let viewsToStyle = [keyTextField, valueTextField]
    for view in viewsToStyle {
      view.backgroundColor = showing ? activeColor : inactiveColor
    }
  }
  
  // MARK: UITableViewDataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseId, forIndexPath: indexPath) as UITableViewCell
    let name = sortedNames[indexPath.row]
    cell.textLabel?.text = name
    cell.detailTextLabel?.text = contacts[name] ?? "(no email)"
    return cell
  }
  
  func addContactWithName(name: String, andEmail email: String) {
    if name.isEmpty || email.isEmpty { return }
    contacts[name] = email
    tableView.reloadData()
  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    switch textField {
    case keyTextField:
      valueTextField.becomeFirstResponder()
    case valueTextField:
      addContactWithName(keyTextField.text, andEmail: valueTextField.text)
      keyTextField.text = ""
      valueTextField.text = ""
      valueTextField.resignFirstResponder()
    default:
      break
    }
    return true
  }
  
  // MARK: NSNotifications
  func keyboardWillShow(notification: NSNotification) {
    updateStylesForKeyboardShowing(true)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    updateStylesForKeyboardShowing(false)
  }
}


















