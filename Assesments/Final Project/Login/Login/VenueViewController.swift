//
//  VenueViewController.swift
//  Login
//
//  Created by Matthew Korporaal on 2/23/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Parse

protocol VenueViewControllerDelegate {
    func venueViewControllerDidReturn()
}
class VenueViewController: UIViewController, ArtistViewControllerDelegate {
    
    @IBOutlet weak var venueListView: AMTagListView!
    var delegate: VenueViewControllerDelegate!
    var venues = [PFObject]()
    var userVenues = [String: PFObject]()
    let parseHelper = ParseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        var tag = Tag()
        tag.setTagAttributes()
        
        var query = PFQuery(className: "Venue")
        query.selectKeys(["name"])
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Add each tag from database to the big list
                self.venues = objects as [PFObject]
                for venue in self.venues {
                    if let venueName = venue["name"] as? String {
                        // Create a new AMTagView
                        self.venueListView.addTag("\(venueName) +")
                        // Set a tap handler that fires when button is pressed
                        self.venueListView.setTapHandler(){ (venueView: AMTagView!) -> Void in
                            (self.venueListView!, self.userVenues) = tag.toggleTag(venueView!, tagList: self.venueListView, userTags: self.userVenues, pfObject: venue)
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
        parseHelper.addRelationalObjectsAndCache("venues", objects: userVenues)
        
        // Save user whenever possible
        userSession.saveEventually(nil)
        
        self.performSegueWithIdentifier("artists", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "artists" {
            var artistViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ArtistViewController") as ArtistViewController
            self.navigationController?.pushViewController(artistViewController, animated: true)
        }
    }
    
    func artistViewControllerDidReturn() {
        parseHelper.removeRelationalObjectsAndCache("venues")
    }

//    override func viewDidUnload() {
//        super.viewDidUnload()
//        self.delegate.venueViewControllerDidReturn()
//    }
    
}
