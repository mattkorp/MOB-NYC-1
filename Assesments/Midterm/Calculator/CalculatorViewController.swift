//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Matthew Korporaal on 2/10/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    private var calculator = Calculator()
    private var calculatorView = CalculatorView()
    private var operand = [String]()
    private var userIsTypingNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.loadDisplay(self.view)
        
    }
    
    /**
    Target set in CalculatorView. Appends digit to operand, if valid
    
    :param: sender the button pressed
    */
    internal func digitPressed(sender: UIButton) {
        var newDigit = sender.currentTitle!
        if validateInput(newDigit) {
            operand.append(newDigit)
            
            // update view
            calculatorView.updateDisplayOutput(displayString())
        } else {
            assert(validateInput(newDigit), "Unhandled userInput")
        }
    }
    
    /**
    Helper method to translate input for the display
    
    :returns: String for display
    */
    private func displayString() -> String {
        return ("").join(operand)
    }

    /**
    Target method set in ButtonView that handles operations
    
    :param: sender <#sender description#>
    */
    internal func operationPressed(sender: UIButton) {
        if let keyOp = sender.titleLabel?.text {
            let op = Op()
            if let operation = op.fromRaw(keyOp) {
                
                switch operation {
                case .AllClear:
                    println("allClear")
                    operand.removeAll(keepCapacity: false)
                    operand.append("0")
                    calculatorView.updateDisplayOutput(displayString())
                case .Parity:
                    println("parity")
                case .Percent:
                    println("percent")
                case .Divide:
                    println("divide")
                case .Multiply:
                    println("mult")
                case .Subtract:
                    println("sub")
                case .Add:
                    println("add")
                case .Equal:
                    println("equal")
                }
            }
        }
        println("op: \(sender.currentTitle!)")
        // Do NOT update CalcView
        
        // set op locally, can change if another op is chosen
    }
    
    private func validateInput(digit: String) -> Bool {
        if userIsTypingNumber {
            // Don't add multiple decimals
            if digit == "." {
                if let decimal = displayString().rangeOfString(".") {
                    return false
                }
            }
        } else {
            // Don't prepend zeros to operand
            if digit == "0" {
                return false
            }
            // Prepend a "0" if decimal is pressed first
            else if digit == "." {
                userIsTypingNumber = true
                operand.append("0")
            }
            userIsTypingNumber = true
        }
        return true
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
}
