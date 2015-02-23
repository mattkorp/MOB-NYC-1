//
//  TagViewController.swift
//  Login
//
//  Created by Matthew Korporaal on 2/20/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Parse

class CategoryViewController: UIViewController, VenueViewControllerDelegate {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var categoryListView: AMTagListView!
    
    var user: PFUser!
    var categories = [PFObject]()
    var userCategories = [String: PFObject]()
    let parseHelper = ParseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.welcomeLabel.text = "\(self.welcomeLabel.text!)\(userSession.username!)"

        var tag = Tag()
        tag.setTagAttributes()
        
        var query = PFQuery(className: "Category")
        query.selectKeys(["name"])
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Add each tag from database to the big list
                self.categories = objects as [PFObject]
                for category in self.categories {
                    if let categoryName = category["name"] as? String {
                        // Create a new AMTagView
                        self.categoryListView.addTag("\(categoryName) +")
                        // Set a tap handler that fires when button is pressed
                        self.categoryListView.setTapHandler(){ (categoryView: AMTagView!) -> Void in
                            (self.categoryListView!, self.userCategories) = tag.toggleTag(categoryView!, tagList: self.categoryListView, userTags: self.userCategories, pfObject: category)
                            sleep(0) // Here so closure doesn't return the tuple above
                        }
                    }
                }
            } else {
                println(error)
            }
        }
    }
    
    @IBAction func nextPressed(sender: UIButton) {
        // Save user categories to Parse and cache
        parseHelper.addRelationalObjectsAndCache("categories", objects: userCategories)
        
        // Save user whenever possible
        userSession.saveEventually(nil)
        
        self.performSegueWithIdentifier("venues", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "venues" {
            var venueViewController = self.storyboard?.instantiateViewControllerWithIdentifier("VenueViewController") as VenueViewController
            self.navigationController?.pushViewController(venueViewController, animated: true)
        }
    }
    
    func venueViewControllerDidReturn() {
        parseHelper.removeRelationalObjectsAndCache("categories")
    }

}
