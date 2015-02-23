//
//  ArtistViewController.swift
//  Login
//
//  Created by Matthew Korporaal on 2/23/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Parse

protocol ArtistViewControllerDelegate {
    func artistViewControllerDidReturn()
}
class ArtistViewController: UIViewController {

    @IBOutlet weak var artistListView: AMTagListView!
    var delegate: ArtistViewControllerDelegate!
    var artists = [PFObject]()
    var userArtists = [String: PFObject]()
    let parseHelper = ParseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tag = Tag()
        tag.setTagAttributes()
        
        var query = PFQuery(className: "Artist")
        query.selectKeys(["name"])
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Add each tag from database to the big list
                self.artists = objects as [PFObject]
                for artist in self.artists {
                    if let artistName = artist["name"] as? String {
                        // Create a new AMTagView
                        self.artistListView.addTag("\(artistName) +")
                        // Set a tap handler that fires when button is pressed
                        self.artistListView.setTapHandler(){ (artistView: AMTagView!) -> Void in
                            (self.artistListView!, self.userArtists) = tag.toggleTag(artistView!, tagList: self.artistListView, userTags: self.userArtists, pfObject: artist)
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
        parseHelper.addRelationalObjectsAndCache("artists", objects: userArtists)
        
        // Save user whenever possible
        userSession.saveEventually(nil)
        
        
        // To tabbar scenes
//        self.performSegueWithIdentifier("??", sender: self)
        
    }
    

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "??" {
//            var ??ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("??ViewController") as ??ViewController
//            self.navigationController?.pushViewController(??ViewController, animated: true)
//        }
//    }

}
