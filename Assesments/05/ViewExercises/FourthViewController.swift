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

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.exerciseView.frame.width, height: self.exerciseView.frame.width))
        scrollView.scrollEnabled = true
        scrollView.delegate = self
        self.exerciseView.addSubview(scrollView)

        purpleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.exerciseView.frame.width, height: 1000))
        purpleLabel.backgroundColor = UIColor.purpleColor()
        scrollView.addSubview(purpleLabel)
        
        blueBox = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        blueBox.backgroundColor = UIColor.blueColor()
        scrollView.addSubview(blueBox)
        redBox = UIView(frame: CGRect(x: 0, y: 1000, width: 20, height: 20))
        redBox.backgroundColor = UIColor.redColor()
        scrollView.addSubview(redBox)
        

        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func next() {
        self.performSegueWithIdentifier("five", sender: nil)
    }

}
