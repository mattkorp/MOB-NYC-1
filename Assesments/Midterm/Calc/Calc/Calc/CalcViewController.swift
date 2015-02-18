//
//  ViewController.swift
//  Calc
//
//  Created by Matthew Korporaal on 2/14/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    // Views for Display/Output
    private let displayContainerView = UIView()
    private let displayContents = UIView()
    private let displayLabel = UILabel()

    // Views for Keys/Buttons
    private let buttonsContainerView = UIView()
    private var buttonArray: [UIButton] = []
    
    // Calculator model
    private let calc = Calculator()
    private let calculatorKeys = Ops().getCalcKeys()
    private var isUserInputtingNumber = false
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadUI()
    }
    
    /**
    Calls methods to make display and buttons.
    Called from viewDidLoad
    */
    private func loadUI() {
        self.makeContainersForCalculatorComponents()
        self.makeCalculatorDisplay()
        self.makeCalculatorButtons()
    }
    
    /**
    Initialize containers for display and buttons
    */
    private func makeContainersForCalculatorComponents() {
        // Display Container
        self.displayContainerView.backgroundColor = UIColor(red:0.17, green:0.15, blue:0.11, alpha:1)
        self.displayContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.displayContainerView)
        
        // Display Container constraints
        self.displayContainerView.snp_makeConstraints { make in
            make.height.equalTo(self.view.snp_height).multipliedBy(0.22)
            make.width.equalTo(self.view.snp_width)
            make.top.equalTo(self.view.snp_top)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
        }
        
        // Button Container
        buttonsContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        buttonsContainerView.backgroundColor = UIColor.brownColor()
        self.view.addSubview(buttonsContainerView)
        
        // Button Container constraints
        self.buttonsContainerView.snp_makeConstraints { make in
            make.height.equalTo(self.view.snp_height).multipliedBy(0.78)
            make.top.equalTo(self.displayContainerView.snp_bottom)
            make.width.equalTo(self.view.snp_width)
            make.bottom.equalTo(self.view.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
        }
    }
    
    /**
    Make display for output and add to container
    */
    private func makeCalculatorDisplay() {

        // Calculator display
        self.displayLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds))
        self.displayLabel.backgroundColor = UIColor(red:0.17, green:0.15, blue:0.11, alpha:1)
        self.displayLabel.textColor = UIColor.whiteColor()
        self.displayLabel.text = "0"
        self.displayLabel.textAlignment = NSTextAlignment.Right
        self.displayLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 70)
        self.displayLabel.adjustsFontSizeToFitWidth = true
        self.displayLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.displayLabel.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        self.displayContainerView.addSubview(self.displayLabel)
        
        // Update Display when calculator model makes a change
        NSNotificationCenter.defaultCenter().addObserverForName("DigitUpdated", object: nil, queue: nil) { (notification: NSNotification!) -> Void in
            if let calc = notification.object! as? Calculator {
                if calc.result == 0.0 {
                    self.updateDisplay("0")
                } else {
                    self.displayValue = calc.result
                }
            }
        }
    }
    
    /**
    Create buttons and add to container
    */
    private func makeCalculatorButtons() {

        // Make Buttons
        var colorCount = 1
        for (index, buttonName) in enumerate(calculatorKeys.keys) {
            var button = UIButton()
            button.setTitle("\(buttonName)", forState: UIControlState.Normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1).CGColor
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            // Set background colors
            // Last Column
            if index == (4 * (colorCount - 1) + 3) {
                button.backgroundColor = UIColor(red:0.96, green:0.57, blue:0.22, alpha:1)
                button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
//                button.addTarget(self, action: "thickBorder:", forControlEvents: UIControlEvents.TouchDown)
//                button.addTarget(self, action: "thinBorder:", forControlEvents: UIControlEvents.TouchUpOutside)
                colorCount++
            // Top row
            } else if 0...2 ~= index {
                button.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            // The rest
            } else {
//                var tap = UITapGestureRecognizer(target: self, action: "thinBorders")
//                button.addGestureRecognizer(tap)
                button.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
            
            // Animate background colors
            button.addTarget(self, action: "lowlight:", forControlEvents: .TouchDown)
            button.addTarget(self, action: "unLowlight:", forControlEvents: .TouchUpInside)
            
            // Add target for keypress
            button.addTarget(self, action: "keyPressed:", forControlEvents: .TouchUpInside)
            
            self.buttonArray.append(button)
            self.buttonsContainerView.addSubview(button)
        }
        constraintsForCalculatorButtons()
    }
    
    /**
    Button Constraints
    */
    private func constraintsForCalculatorButtons() {
        // equal height & widths
        for (index, button) in enumerate(self.buttonArray) {
            self.buttonArray[index].snp_makeConstraints { make in
                // Set button equal widths and heights
                if index != (self.buttonArray.count - 1) {
                    make.height.equalTo(self.buttonArray[index+1].snp_height)
                    make.width.equalTo(self.buttonArray[index+1].snp_width)
                }
            }
        }
        
        let numberOfButtons = buttonArray.count
        let numberOfRows = 5
        let numberOfColumns = numberOfButtons / numberOfRows
        // Make array of column indices
        let columns = (0..<numberOfColumns).map {
            (column) in (0..<numberOfRows).map {
                (row) in numberOfColumns * row + column
            }
        }
        // Make array of row indices
        let rows = (0..<numberOfRows).map {
            (row) in (0..<numberOfColumns).map {
                (column) in numberOfColumns * row + column
            }
        }
        
        // Make row constraints
        let rowRange: Range = 0..<numberOfColumns
        let topRow: ClosedInterval = 0...3, bottomRow: ClosedInterval = 16...19
        for row in rows {
            for index in rowRange {
                switch row[index] {
                case topRow:
                    self.buttonArray[row[index]].snp_makeConstraints { make in
                        make.top.equalTo(self.buttonsContainerView.snp_top)
                        make.bottom.equalTo(self.buttonArray[row[index]+numberOfColumns].snp_top)
                    }
                case bottomRow:
                    self.buttonArray[row[index]].snp_makeConstraints { make in
                        make.bottom.equalTo(self.buttonsContainerView.snp_bottom)
                        return
                    }
                default:
                    buttonArray[row[index]].snp_makeConstraints { make in
                        make.bottom.equalTo(self.buttonArray[row[index]+numberOfColumns].snp_top)
                        return
                    }
                }
            }
        }
        
        // Make column constraints
        let columnRange: Range = 0..<numberOfRows
        for column in columns {
            for index in columnRange {
                switch column[index] {
                    // first column
                case (4*index):
                    self.buttonArray[column[index]].snp_makeConstraints { make in
                        make.left.equalTo(self.buttonsContainerView.snp_left)
                        make.right.equalTo(self.buttonArray[column[index]+1].snp_left)
                    }
                    // last column
                case ((4*index)+3):
                    self.buttonArray[column[index]].snp_makeConstraints { make in
                        make.right.equalTo(self.buttonsContainerView.snp_right)
                        return
                    }
                default:
                    self.buttonArray[column[index]].snp_makeConstraints { make in
                        make.right.equalTo(self.buttonArray[column[index]+1].snp_left)
                        return
                    }
                }
            }
        }
    }
    
    /**
    Target set in CalculatorView. Appends digit to operand, if valid
    :param: sender the button pressed
    */
    internal func keyPressed(sender: UIButton) {
        let keyName = sender.currentTitle!
        let key = calculatorKeys[keyName]
    
        if key == "digit" {
            if keyName == "." && displayLabel.text!.rangeOfString(".") != nil {
                return
            }
            if isUserInputtingNumber {
                self.updateDisplay(displayLabel.text! + keyName)
            } else {
                isUserInputtingNumber = true
                self.updateDisplay(keyName)
            }
        } else if key != "digit" {
            isUserInputtingNumber = false
            self.calc.pushOperand(displayValue)
            self.calc.pushOperation(keyName)
        }
    }
    
    /**
    Add key names to Display while user is inputting
    :param: displayText String to display
    */
    private func updateDisplay(displayText: String) {
        self.displayLabel.text = displayText
    }

    // Add result to display as a string or gets a Double
    var displayValue: Double {
        get {
            return (self.displayLabel.text! as NSString).doubleValue
        }
        set {
            self.displayLabel.text = "\(newValue)"
            self.isUserInputtingNumber = false
        }
    }
// TODO: Once goes thick, it doesn't want to go back. feeble attempts
//    var thickButton: UIButton?
//    func thickBorder(sender: UIButton) {
//        sender.layer.borderWidth = 2
//        thickButton = sender
//    }
//    func thinBorder(sender: UIButton) {
//        sender.layer.borderWidth = 0.5
////        self.view.setNeedsLayout()
////        self.view.layoutIfNeeded()
//
//    }
//    func thinBorders() {
//        if let button = thickButton {
//            button.layer.borderWidth = 0.5
//        }
//    }
    
    /**
    Lowlights button by making rgb value darker
    :param: sender button that was pressed
    */
    func lowlight(sender: UIButton) {
        let lowlightConstant: CGFloat = 0.1
        var rgba = [CGFloat(), CGFloat(), CGFloat(), CGFloat()]
        sender.backgroundColor?.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        rgba = rgba.map { $0 - lowlightConstant }
        sender.backgroundColor? = UIColor(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
    
    /**
    Removes lowlight by adding the constant that darkened it
    :param: sender UIButton
    */
    func unLowlight(sender: UIButton) {
        let lowlightConstant: CGFloat = 0.1
        var rgba = [CGFloat(), CGFloat(), CGFloat(), CGFloat()]
        sender.backgroundColor?.getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        rgba = rgba.map { $0 + lowlightConstant }
        sender.backgroundColor? = UIColor(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
 
}

