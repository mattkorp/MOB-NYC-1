//
//  ViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ArrayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
  
  let cellReuseID = "cell"
  lazy var tableView: UITableView = {
    let tv = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseID)
    tv.delegate = self
    tv.dataSource = self
    self.view.addSubview(tv)
    return tv
  }()
  var notes = [String]()
  
  lazy var textField: UITextField = {
    let tf = UITextField()
    tf.delegate = self
    self.view.addSubview(tf)
    tf.layer.borderWidth = 1
    return tf
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareLayout()
    tableView.reloadData()
    
    //        TODO one: Add a table view AND a text input box to this view controller, either in code or via the storyboard. Accept keyboard input from the text view when the return key is pressed. Add the string that was entered into the text view into an array of strings (stored in this class).
    
    
    //        TODO two: Make this class a UITableViewDelegate and UITableViewDataSource that supply the above table view with cells. These cells should correspond to the text entered into the text box. E.g. If the text "one", then "two", then "three" was entered into the text box, there should be three cells in this table view that contain those strings in order.
  }
  
  
  // MARK: Layout
  func prepareLayout() {
    textField.setTranslatesAutoresizingMaskIntoConstraints(false)
    let tfTop = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1.0, constant: 80)
    let tfWidth = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 200)
    let tfHeight = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
    let tfX = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
    self.view.addConstraints([tfTop, tfWidth, tfHeight, tfX])
    
    tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
    let tvTop = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: textField, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 8.0)
    let tvBottom = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
    let tvLeft = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
    let tvRight = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
    self.view.addConstraints([tvTop, tvBottom, tvLeft, tvRight])
  }
  
  func addTextToDataSource(text: String) {
    if text.isEmpty { return }
    notes += [text]
    tableView.reloadData()
  }
  
  // MARK: UITableView DataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = notes[indexPath.row]
    return cell
  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    addTextToDataSource(textField.text)
    textField.text = ""
    textField.resignFirstResponder()
    return true
  }
  
}
















