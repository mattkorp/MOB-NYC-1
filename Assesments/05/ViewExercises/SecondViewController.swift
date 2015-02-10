//
//  SecondViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class SecondViewController: ExerciseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 2"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build four blue squares, 20 points wide, one in each corner of the screen. 
        They must stay in their respective corners on device rotation. 
        
        Use Springs & Struts.
        
        Your view should be in self.exerciseView, not self.view
        */
        var boxWidth:CGFloat = 20
        var boxHeight:CGFloat = 20
        
        var orientation = UIDevice.currentDevice().orientation
        if orientation == UIDeviceOrientation.Portrait {
            getVisibleContainerSizes(self.view.frame.width, height: self.view.frame.height)
        } else {
            getVisibleContainerSizes(self.view.frame.height, height: self.view.frame.width)
        }
        
        let ulBox = UIView(frame: CGRect(x: 0, y: topLayoutHeight, width: boxWidth, height: boxHeight))
        ulBox.backgroundColor = UIColor.blueColor()
        ulBox.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin
        self.exerciseView.addSubview(ulBox)

        let urBox = UIView(frame: CGRect(x: width-boxWidth, y: topLayoutHeight, width: boxWidth, height: boxHeight))
        urBox.backgroundColor = UIColor.blueColor()
        urBox.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleLeftMargin
        self.exerciseView.addSubview(urBox)

        let llBox = UIView(frame: CGRect(x: 0, y: height-boxHeight, width: boxWidth, height: boxHeight))
        llBox.backgroundColor = UIColor.blueColor()
        llBox.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleRightMargin
        self.exerciseView.addSubview(llBox)

        let lrBox = UIView(frame: CGRect(x: width-boxWidth, y: height-boxHeight, width: boxWidth, height: boxHeight))
        lrBox.backgroundColor = UIColor.blueColor()
        lrBox.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleLeftMargin
        self.exerciseView.addSubview(lrBox)

    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func next() {
        self.performSegueWithIdentifier("three", sender: nil)
    }
}
