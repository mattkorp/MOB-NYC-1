//
//  InfoViewController.swift
//  Lesson03
//
//  Created by trvslhlt on 1/17/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import UIKit

protocol InfoVCDelegate {
  func infoVCDismissed()
}

class InfoViewController: UIViewController {
  
  var delegate: InfoVCDelegate?
  
  @IBAction func dismissTapped(sender: AnyObject) {
    delegate?.infoVCDismissed()
    //this is an example of a completion closure, and asynchronous action
    self.dismissViewControllerAnimated(true, completion: { print("done!") })
  }

}
