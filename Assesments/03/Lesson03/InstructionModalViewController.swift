//
//  InstructionModalViewController.swift
//  Lesson03
//
//  Created by Matthew Korporaal on 1/19/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation
import UIKit

class InstructionModalViewController: UIViewController {

    let modalImage:UIImage! = UIImage(named: "schematic.jpg")
    let dismissButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    let modalLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        TODO one: Hook up a swipeable area on the home screen that must present a modal dialog when swiped. You must create the modal dialog and present it in CODE (not the storyboard).
        */
        
        // set transition style
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        // build the view
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.2, alpha: 1.0)
        
        // TODO two: Add an imageview to the modal dialog presented in TODO two.

        if (modalImage != nil) {
            let modalImageView = UIImageView(image: modalImage)
            modalImageView.frame = view.frame
            modalImageView.frame = CGRectMake(20, 20, 300, 158)
            view.addSubview(modalImageView)
        } else {
            println("image not found")
        }
        
        /*
            TODO three: Add and hook up a ‘dismiss’ button below the above mentioned image view that will dismiss the modal dialog. Do this in CODE.
        */
        dismissButton.setTitle("Done", forState: .Normal)
        dismissButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        dismissButton.titleLabel?.textAlignment = .Center
        dismissButton.frame = CGRectMake(20, 200, 200, 50)
        dismissButton.addTarget(self, action: "modalDidFinish", forControlEvents: .TouchUpInside)
        view.addSubview(dismissButton)
        
        
        
    }
    
    func modalDidFinish() {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    
}
