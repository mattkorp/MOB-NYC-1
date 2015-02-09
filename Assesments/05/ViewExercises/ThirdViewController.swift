//
//  ThirdViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class ThirdViewController: ExerciseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 3"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build four blue squares, 20 points wide, one in each corner of the screen.
        They must stay in their respective corners on device rotation. 
        
        Use Autolayout.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        let boxWidth: CGFloat = 20
        let boxHeight = boxWidth
        
        var ulBox = UIView()
        ulBox.frame.origin.x = 0
        ulBox.frame.origin.y = 0
        ulBox.backgroundColor = UIColor.blueColor()
        
        ulBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.exerciseView.addSubview(ulBox)
        
        let ulW = NSLayoutConstraint(item: ulBox, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxWidth)
        let ulH = NSLayoutConstraint(item: ulBox, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxHeight)
        let ulB = NSLayoutConstraint(item: ulBox, attribute: .Top, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let ulL = NSLayoutConstraint(item: ulBox, attribute: .Left, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Left, multiplier: 1.0, constant: 0.0)
        self.exerciseView.addConstraints([ulW, ulH, ulB, ulL])

        var urBox = UIView()
        urBox.frame.origin.x = exerciseView.frame.width - boxWidth
        urBox.frame.origin.y = 0
        urBox.backgroundColor = UIColor.blueColor()
        
        urBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.exerciseView.addSubview(urBox)
        
        let urW = NSLayoutConstraint(item: urBox, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxWidth)
        let urH = NSLayoutConstraint(item: urBox, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxHeight)
        let urB = NSLayoutConstraint(item: urBox, attribute: .Top, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let urL = NSLayoutConstraint(item: urBox, attribute: .Right, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Right, multiplier: 1.0, constant: 0.0)
        self.exerciseView.addConstraints([urW, urH, urB, urL])

        var llBox = UIView()
        llBox.frame.origin.x = 0
        llBox.frame.origin.y = exerciseView.frame.height - boxHeight
        llBox.backgroundColor = UIColor.blueColor()
        
        llBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.exerciseView.addSubview(llBox)
        
        let llW = NSLayoutConstraint(item: llBox, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxWidth)
        let llH = NSLayoutConstraint(item: llBox, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxHeight)
        let llB = NSLayoutConstraint(item: llBox, attribute: .Bottom, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let llL = NSLayoutConstraint(item: llBox, attribute: .Left, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Left, multiplier: 1.0, constant: 0.0)
        self.exerciseView.addConstraints([llW, llH,llB, llL])
        
        var lrBox = UIView()
        lrBox.frame.origin.x = exerciseView.frame.width - boxWidth
        lrBox.frame.origin.y = exerciseView.frame.height - boxHeight
        lrBox.backgroundColor = UIColor.blueColor()
        lrBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.exerciseView.addSubview(lrBox)
        
        let lrW = NSLayoutConstraint(item: lrBox, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxWidth)
        let lrH = NSLayoutConstraint(item: lrBox, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: boxHeight)
        let lrB = NSLayoutConstraint(item: lrBox, attribute: .Bottom, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let lrL = NSLayoutConstraint(item: lrBox, attribute: .Right, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Right, multiplier: 1.0, constant: 0.0)
        self.exerciseView.addConstraints([lrW, lrH, lrB, lrL])
        

    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func next() {
        self.performSegueWithIdentifier("four", sender: nil)
    }

}
