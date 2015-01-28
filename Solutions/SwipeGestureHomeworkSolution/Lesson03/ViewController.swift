//
//  ViewController.swift
//  Lesson03
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InfoVCDelegate {
    
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSwipe()
    prepareButton()
  }
  
//    TODO one: Hook up a swipeable area on the home screen that must present a modal dialog when swiped. You must create the modal dialog and present it in CODE (not the storyboard).

  func prepareSwipe() {
    let swipeGR = UISwipeGestureRecognizer(target: self, action: Selector("didSwipe:"))
    swipeGR.direction = UISwipeGestureRecognizerDirection.Up
    label.addGestureRecognizer(swipeGR)
  }
  
  func prepareButton() {
    button.hidden = true
  }
  
  func didSwipe(sender: UISwipeGestureRecognizer) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let infoVC = storyboard.instantiateViewControllerWithIdentifier("InfoViewController") as InfoViewController
    infoVC.delegate = self
    self.presentViewController(infoVC, animated: true, completion: nil)
  }


//    TODO two: Add an imageview to the modal dialog presented in TODO two.
//    TODO three: Add and hook up a ‘dismiss’ button below the above mentioned image view that will dismiss the modal dialog. Do this in CODE.
  
//    TODO four: Hook up the button on the home screen to push ArrayTableViewController into view (via the navigation controller) when tapped. Do this by triggering a segue from this view controller. The method you are looking for is performSegueWithIdentifier. Find the identifier from the storyboard.
  
  @IBAction func displayTapped(sender: AnyObject) {
    self.performSegueWithIdentifier("show", sender: self)
  }
  
  // MARK: InfoVCDelegate
  func infoVCDismissed() {
    label.text = "you don't have to swipe again, but you can if you would like to."
    button.hidden = false
  }
  
  
}




















