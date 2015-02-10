//
//  FourthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FourthViewController: ExerciseViewController, UIScrollViewDelegate {
    var scrollView = UIScrollView()
    var contentView = UIView()
    var blueBox = UIView()
    var redBox = UIView()
    var purpleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 4"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build a scroll view that takes up the entire screen. 
        
        In the scroll view, place a blue box at the top (20px high, 10px horizontal margins with the screen, a very tall (1000+px, width the same as the screen) purple label containing white text in the middle, and a red box at the bottom (20px high, 10px horizontal margins with the screen). The scroll view should scroll the entire height of the content.
        
        Use Autolayout.

        
        Your view should be in self.exerciseView, not self.view.
        */

        // Springs & Struts style..
        // set .contentSize
        // scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.exerciseView.frame.width, height: self.exerciseView.frame.height))
        //scrollView.contentSize = CGSize(width: self.exerciseView.frame.width, height: 1000)
        
        // Auto-Layout style..
        // Add UIScrollView to Container and set the VC as the delegate
        scrollView.scrollEnabled = true
        scrollView.maximumZoomScale = 5
        scrollView.delegate = self
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.exerciseView.addSubview(scrollView)

        // Pin each corner to container
        self.exerciseView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Top, multiplier: 1.0, constant: 0.0))
        self.exerciseView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        self.exerciseView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Left, multiplier: 1.0, constant: 0.0))
        self.exerciseView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Right, multiplier: 1.0, constant: 0.0))
        
        // Create content UIView (or scrollable area) and add to UIScrollView
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.addSubview(contentView)
        
        // Setting Content UIView area to 1000X1000
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1000.0))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1000.0))
        // Pin the Content UIView to each side of the UIScrollView
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0.0))
        
        purpleLabel = UILabel()// (frame: CGRect(x: 0, y: 0, width: self.exerciseView.frame.width, height: 1000))
        purpleLabel.backgroundColor = UIColor.purpleColor()
        purpleLabel.textColor = UIColor.redColor()
        purpleLabel.textAlignment = NSTextAlignment.Center
        purpleLabel.text = "Purple Label"
        contentView.addSubview(purpleLabel)
        
        // Make the Label the width of the container UIView, 1000 pts tall, and pin to top-left corner
        purpleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addConstraint(NSLayoutConstraint(item: purpleLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 320))
        contentView.addConstraint(NSLayoutConstraint(item: purpleLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1000.0))
        contentView.addConstraint(NSLayoutConstraint(item: purpleLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: purpleLabel, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 0.0))
        
        
//
        blueBox = UIView()
        blueBox.backgroundColor = UIColor.blueColor()
        contentView.addSubview(blueBox)
        blueBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addConstraint(NSLayoutConstraint(item: blueBox, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint(item: blueBox, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint(item: blueBox, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 10.0))
        contentView.addConstraint(NSLayoutConstraint(item: blueBox, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 10.0))
        
        redBox = UIView()
        redBox.backgroundColor = UIColor.redColor()
        contentView.addSubview(redBox)
        redBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addConstraint(NSLayoutConstraint(item: redBox, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint(item: redBox, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20.0))
        contentView.addConstraint(NSLayoutConstraint(item: redBox, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: -10.0))
        contentView.addConstraint(NSLayoutConstraint(item: redBox, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 10.0))

        
        
        
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        
    }
    override func viewDidLayoutSubviews() {
        
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
//    override func supportedInterfaceOrientations() -> Int {
//        return UIInterfaceOrientation.Portrait.rawValue
//    }
    
    func next() {
        self.performSegueWithIdentifier("five", sender: nil)
    }

}
