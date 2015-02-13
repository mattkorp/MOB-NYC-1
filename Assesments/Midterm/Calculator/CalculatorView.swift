//
//  CalculatorOutputView.swift
//  Calculator
//
//  Created by Matthew Korporaal on 2/11/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Snap

class CalculatorView: UILabel {
    
    private var displayLabel = UILabel()
    private var view = UIView()
    private var buttonView = CalculatorButtonView()

    func loadDisplay(view: UIView) {
        self.view = view
        createOutputView()
        buttonView.loadButtons(self.view, display: self.displayLabel)

    }

    func createOutputView() {
        
        // Calculator display
        self.displayLabel.backgroundColor = UIColor(red:0.17, green:0.15, blue:0.11, alpha:1)
        self.displayLabel.textColor = UIColor.whiteColor()
        self.displayLabel.text = "0"
        self.displayLabel.textAlignment = NSTextAlignment.Right
        self.displayLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 50)
        self.view.addSubview(self.displayLabel)
        
        self.displayLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.displayLabel.snp_makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(self.view.snp_width)
            make.top.equalTo(self.view.snp_top)
            make.right.equalTo(self.view.snp_right)
            make.left.equalTo(self.view.snp_left)
        }
    }
    


    /**
    <#Description#>
    
    :param: digit <#digit description#>
    */
    func updateDisplayOutput(output: String) {
        displayLabel.text? = output
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            displayLabel.text = "\(newValue)"
        }
    }
    
    // TODO: Inset text on output display
    // try UILabel with no background set to a UIView with the background set. Set the label's x to 10 and make the outer view's size 10 pixels wider than the label.
    // instead of subclassing uilabel
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return super.textRectForBounds(bounds, limitedToNumberOfLines: 1)
    }
}
