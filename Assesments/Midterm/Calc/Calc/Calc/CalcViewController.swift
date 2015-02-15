//
//  ViewController.swift
//  Calc
//
//  Created by Matthew Korporaal on 2/14/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    private let displayContainerView: UIView!
    private let displayContents: UIView!
    private let displayLabel: UILabel!

    private let buttonsContainerView: UIView!
    private var buttonArray: [UIButton] = []
    
    private let calc: Calc!
    
    override init() {
        super.init()
        displayContainerView = UIView()
        displayContents =  UIView()
        displayLabel = UILabel()
        buttonsContainerView = UIView()
        
        calc = Calc()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display Container
        displayContainerView.backgroundColor = UIColor(red:0.17, green:0.15, blue:0.11, alpha:1)
        displayContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(displayContainerView)

        // Calculator display
        self.displayLabel.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-30, CGRectGetHeight(self.view.frame))
        self.displayLabel.backgroundColor = UIColor(red:0.17, green:0.15, blue:0.11, alpha:1)
        self.displayLabel.textColor = UIColor.whiteColor()
        self.displayLabel.text = "0"
        self.displayLabel.textAlignment = NSTextAlignment.Right
        self.displayLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 70)
        self.displayLabel.adjustsFontSizeToFitWidth = true
        self.displayLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.displayLabel.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin
        displayContainerView.addSubview(displayLabel)
        
        // Button Container
        buttonsContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        buttonsContainerView.backgroundColor = UIColor.brownColor()
        self.view.addSubview(buttonsContainerView)
        
        // Make Buttons
        let buttonNames = [
            "AC","±","%","÷",
            "7","8","9","×",
            "4","5","6","−",
            "1","2","3","+",
            "0",".","√","=" ]
        
        var colorCount = 1
        for (index, name) in enumerate(buttonNames) {
            var button = UIButton()
            button.setTitle("\(buttonNames[index])", forState: UIControlState.Normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1).CGColor
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
            button.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            // Background colors
            if index == (4 * (colorCount - 1) + 3) {
                button.backgroundColor = UIColor(red:0.96, green:0.57, blue:0.22, alpha:1)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
                //                button.addTarget(self, action: "borderHighlighted:", forControlEvents: UIControlEvents.TouchDown)
                //                button.addTarget(self, action: "bordernHighlighted:", forControlEvents: UIControlEvents.TouchUpInside)
                colorCount++
            } else if 0...2 ~= index {
                button.backgroundColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1)
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                
            } else {
                button.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1)
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            // Animated background colors
            button.addTarget(self, action: "lowlight:", forControlEvents: UIControlEvents.TouchDown)
            button.addTarget(self, action: "unLowlight:", forControlEvents: UIControlEvents.TouchUpInside)
            
            // addTarget based on key type
            switch buttonNames[index] {
            case "AC","±","%","÷","×","−","+","√","=":
                button.addTarget(self, action: Selector("operationPressed:"), forControlEvents: .TouchUpInside)
            case "7","8","9","4","5","6","1","2","3","0",".":
                button.addTarget(self, action: Selector("digitPressed:"), forControlEvents: .TouchUpInside)
            default:
                break
            }
            
            self.buttonArray.append(button)
            self.buttonsContainerView.addSubview(button)
            
        }
        
        
        let containerHeight = CGRectGetHeight(self.view.frame)
        let displayHeight = containerHeight * (9/13)
        let buttonsHeight = containerHeight * (4/13)
                displayContainerView.snp_makeConstraints { make in
//                    make.height.equalTo(self.view.snp_height).offset(-buttonsHeight)
                    make.width.equalTo(self.view.snp_width)
                    make.top.equalTo(self.view.snp_top)
                    make.bottom.equalTo(self.buttonsContainerView.snp_top)
                    make.left.equalTo(self.view.snp_left)
                    make.right.equalTo(self.view.snp_right)
                }
        
        self.view.addConstraints([
            NSLayoutConstraint(item: displayContainerView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.2, constant: 0.0),
            ])

        
                self.buttonsContainerView.snp_makeConstraints { make in
//                    make.height.equalTo(self.view.snp_height).offset(-displayHeight)
                    make.width.equalTo(self.view.snp_width)
                    make.bottom.equalTo(self.view.snp_bottom)
                    make.left.equalTo(self.view.snp_left)
                    make.right.equalTo(self.view.snp_right)
                }
        self.view.addConstraints([
            NSLayoutConstraint(item: self.buttonsContainerView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.8, constant: 0.0),
            ])
        
        
        // Button Constraints
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
        let topRow: ClosedInterval = 0...3, bottomRow: ClosedInterval = 16...19
        let rowRange: Range = 0..<numberOfColumns
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
        
        // Update Display when calculator makes a change
        NSNotificationCenter.defaultCenter().addObserverForName("DigitUpdated", object: nil, queue: nil) { (notification: NSNotification!) -> Void in
            if let calc = notification.object! as? Calc {
                self.updateDisplay(calc.getDigitString())
            }
        }
    }
    
    /**
    Target set in CalculatorView. Appends digit to operand, if valid
    
    :param: sender the button pressed
    */
    internal func digitPressed(sender: UIButton) {
        let newDigit = sender.currentTitle!
        self.calc.validateDigit(newDigit)
    }
    
    internal func operationPressed(sender: UIButton) {
        let newOp = sender.currentTitle!
        self.calc.evaluate(newOp)
    }
    
    private func updateDisplay(output: String) {
        displayLabel.text = output
    }

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

