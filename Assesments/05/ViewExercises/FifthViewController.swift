//
//  FifthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FifthViewController: ExerciseViewController {
    let greenButton = UIButton()
    var verticalConstraint = NSLayoutConstraint()
    var buttonIsHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 5"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Create a green button with a red border that says ‘Tap me!’ (50px by 50px), center it in the middle of the screen.
        Once tapped, the button should animate up 20 pixels and turn red, then immediately back down 20 pixels and turn back to green. It should not be clickable while animating.
        
        Use Autolayout.
        
        Your view should be in self.exerciseView, not self.view
        */
        //greenButton = UIButton(frame: CGRect(x: exerciseView.center.x-25, y: exerciseView.center.y-25, width: 50, height: 50))
        greenButton.setTitle(":)", forState: UIControlState.Normal)
        greenButton.layer.borderColor = UIColor.redColor().CGColor
        greenButton.backgroundColor = UIColor.greenColor()
        greenButton.layer.borderWidth = 1
        greenButton.addTarget(self, action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
        self.exerciseView.addSubview(greenButton)
        
        setConstraints()
        
    }
    
    func tapped() {
        UIView.animateWithDuration(1.0, animations: {
            self.moveBox()
        })
    }
    
    func moveBox() {
        if buttonIsHome {
            verticalConstraint.constant = 30
            greenButton.setTitle(":)", forState: UIControlState.Normal)
            greenButton.backgroundColor = UIColor.greenColor()
            buttonIsHome = false
        } else {
            verticalConstraint.constant = -30
            greenButton.setTitle(":(", forState: UIControlState.Normal)
            greenButton.backgroundColor = UIColor.blueColor()
            buttonIsHome = true
        }
        greenButton.layoutIfNeeded()
    }
    
    func setConstraints() {
        greenButton.setTranslatesAutoresizingMaskIntoConstraints(false)

        let widthConstraint = NSLayoutConstraint(item: greenButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 50)
        let heightConstraint = NSLayoutConstraint(item: greenButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 50)
        let horizontal = NSLayoutConstraint(item: greenButton, attribute: .CenterX, relatedBy: .Equal, toItem: exerciseView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        verticalConstraint = NSLayoutConstraint(item: greenButton, attribute: .CenterY, relatedBy: .Equal, toItem: exerciseView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        self.exerciseView.addConstraints([widthConstraint, heightConstraint, horizontal, verticalConstraint])
        
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func next() {
        self.performSegueWithIdentifier("six", sender: nil)
    }

}
