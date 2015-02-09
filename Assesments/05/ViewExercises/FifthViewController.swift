//
//  FifthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FifthViewController: ExerciseViewController {
    let greenButton: UIButton
    var top: NSLayoutConstraint
    
    override init() {
        greenButton = UIButton()
        top = NSLayoutConstraint()
        super.init(nibName: nil, bundle: nil)
    }
    
    required override init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        greenButton.titleLabel?.text = "Tap Me!"
        greenButton.addTarget(self, action: "tapped", forControlEvents: UIControlEvents.TouchUpInside)
        greenButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.exerciseView.addSubview(greenButton)
        
        setConstraints()
        
    }
    
    func tapped() {
        UIView.animateWithDuration(1.0, animations: {
//            self.frame.minY
        })
    }
    
    func setConstraints() {
        let widthConstraint = NSLayoutConstraint(item: greenButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50)
        let heightConstraint = NSLayoutConstraint(item: greenButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50)
        let left = NSLayoutConstraint(item: greenButton, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: exerciseView, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0)
        let right = NSLayoutConstraint(item: greenButton, attribute: .Right, relatedBy: .Equal, toItem: exerciseView, attribute: .TrailingMargin, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: greenButton, attribute: .Right, relatedBy: .Equal, toItem: exerciseView, attribute: .TrailingMargin, multiplier: 1.0, constant: 0.0)
        top = NSLayoutConstraint(item: greenButton, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: exerciseView, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0)
        
        self.exerciseView.addConstraints([widthConstraint, heightConstraint, left, right, bottom, top])
        
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
