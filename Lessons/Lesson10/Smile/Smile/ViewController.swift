//
//  ViewController.swift
//  Smile
//
//  Created by Rudd Taylor on 2/4/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var centerY: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        autolayout()
    }
    
    func autolayout() {
        var leftEye = UIView()
        var rightEye = UIView()
        leftEye.setTranslatesAutoresizingMaskIntoConstraints(false)
        rightEye.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(leftEye)
        view.addSubview(rightEye)
        leftEye.backgroundColor = UIColor.redColor()
        
        view.addConstraint(NSLayoutConstraint(
            item: leftEye,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0))
        view.addConstraint(NSLayoutConstraint(
            item: leftEye,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: view,
            attribute: .CenterX,
            multiplier: 0.5,
            constant: 0))
        view.addConstraint(NSLayoutConstraint(
            item: leftEye,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50))
        view.addConstraint(NSLayoutConstraint(
            item: leftEye,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50))
        
        leftEye.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTap"))
    }
    
    func didTap() {
        centerY.constant = centerY.constant + 10
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func springsAndStrutsLayout() {
        let topMargin: CGFloat = 50
        let size: CGFloat = 15
        var leftEye = UIView(frame: CGRect(x: self.view.frame.size.width/4, y: topMargin, width: size, height: size))
        var rightEye = UIView(frame: CGRect(x: self.view.frame.size.width * 0.75, y: topMargin, width: size, height: size))
        
        leftEye.backgroundColor = UIColor.purpleColor()
        rightEye.backgroundColor = UIColor.orangeColor()
        
        leftEye.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin
        rightEye.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        
        view.addSubview(leftEye)
        view.addSubview(rightEye)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

