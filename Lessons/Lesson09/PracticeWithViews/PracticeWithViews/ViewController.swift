//
//  ViewController.swift
//  PracticeWithViews
//
//  Created by Rudd Taylor on 2/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("click!", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.redColor()
        self.view.addSubview(button)
        button.addTarget(self, action: "didTapButton", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didTapButton() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.button.frame.origin.y = self.button.frame.origin.y + 20
            self.button.alpha = self.button.alpha - 0.1
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

