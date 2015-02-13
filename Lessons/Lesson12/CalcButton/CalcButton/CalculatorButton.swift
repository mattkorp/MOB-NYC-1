//
//  CalculatorButton.swift
//  CalcButton
//
//  Created by Rudd Taylor on 2/11/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {
    var label: UILabel = UILabel()
    var highlightedColor: UIColor?
    var originalBackgroundColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.addSubview(label)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addConstraint(NSLayoutConstraint(item: label,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        self.addConstraint(NSLayoutConstraint(item: label,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        label.textAlignment = .Center
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.originalBackgroundColor = self.backgroundColor
        self.backgroundColor = highlightedColor
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        func animatedThings() {
            self.backgroundColor = self.originalBackgroundColor
        }
        UIView.animateWithDuration(0.5, animations: {() -> Void in
                self.backgroundColor = self.originalBackgroundColor
            }
        )        
    }
}
