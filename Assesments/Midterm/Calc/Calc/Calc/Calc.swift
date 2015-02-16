//
//  File.swift
//  Calc
//
//  Created by Matthew Korporaal on 2/15/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation

class Calc {
    
    private var isUserInputting: Bool = false
    private let op = Op()
    private let calcKeys: OrderedDictionary<String, String> = Op().getCalcKeys()
    // Store the operations and operands
    private var opStack: [String] = []
    // for calculations
    private var outputDouble: Double
    // for display
    private var outputString: String
    {
        didSet {
            // sync double counterpart and update stack
            outputDouble = (outputString as NSString).doubleValue
            opStack[opStack.count] = self.outputString
            // broadcast updates
            NSNotificationCenter.defaultCenter().postNotificationName("DigitUpdated", object: self)
        }
    }
    
    init() {
//        calcKeys = Op().getCalcKeys()
        self.resetOutput()
    }
    
    internal func getOutputString() -> String {
        return self.outputString
    }
    private func storeDigit(digit: String) {
        self.outputString += digit
    }
    private func storeDigit(digit: Double, precision: Double) {
        self.outputString = String(format: "%\(precision)f", digit)
    }
    private func resetOutput() {
        self.outputString = "0"
    }
    
    internal func evaluate(value: String) {
        let keyCategory: String = self.calcKeys[value]!
        switch keyCategory {
        case "digit":
            if isUserInputting == false {
                isUserInputting = true
                self.opStack.removeAll(keepCapacity: false)
            }
            self.validateDigit(value)
        case "unary":
            if self.isUserInputting {
                self.evaluateUnary(value)
            }
        case "binary":
            // One operand, add operator
            if opStack.count == 1 {
                opStack.append(value)
            // Replace operator
            } else if opStack.count == 2 {
                opStack[opStack.count] = value
                self.evaluateBinary(value)
            } else if opStack.count == 3 {
                self.evaluateBinary(value)
            }
        case "clear":
            self.isUserInputting = false
            self.opStack.removeAll(keepCapacity: false)
            self.resetOutput()
        default:
            return
        }
    }

    // MARK: Operational Methods
    /*
    Validates digit key pressed and updates properties
    :param: digit key title
    :returns: Optional bool, true if valid
    */
    private func validateDigit(digit: String) -> Bool? {
        if digit == "." && (self.outputString.rangeOfString(".") != nil) {
            // Don't add extra ...
            return false
        } else if digit == "0" && self.outputString == "0" {
            // Don't prepend 0000
            return false
        } else if digit != "." && self.outputString == "0" {
            // Drop 0 if first digit
            self.outputString = ""
        }
        self.storeDigit(digit)
        return true
    }

    private func evaluateUnary(op: String) {
        if let unary = self.op.fromRaw(op) {
            switch unary {
            case .Parity:
                self.toggleParity()
            case .Sqrt:
                self.sqRoot()
            case .Percent:
                self.percent()
            default:
                return
            }
        } else {
            println("Cannot handle this operation")
        }
    }
    private func evaluateBinary(op: String) {
        if let binary = self.op.fromRaw(op) {
            switch binary {
            case .Divide:
                self.div()
            case .Multiply:
                self.mult()
            case .Subtract:
                self.sub()
            case .Add:
                self.add()
            case .Equal:
                self.equal()
            default:
                return
            }
            self.operation = op
            self.storeDigit(self.outputDouble, precision: 0.6)
        } else {
            println("Cannot handle this operation")
        }
    }
    
    // MARK: Unary Methods
    private func toggleParity() {
        if self.outputDouble > 0 {
            self.outputString = "-" + self.outputString
        } else {
            self.outputString = self.outputString.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
    }
    private func sqRoot() {
        self.outputDouble = sqrt(self.outputDouble)
        self.storeDigit(self.outputDouble, precision: 0.6)
    }
    private func percent() {
        self.outputDouble! /= 100.0
        self.storeDigit(self.outputDouble, precision: 0.2)
    }
    
    // MARK: Binary Methods
    private func add() {
        self.outputDouble = self.lhsDouble + self.outputDouble
    }
    private func div() {
        if (self.lhsDouble == 0.0) {
            self.resetOutput()
        } else {
            self.outputDouble = self.outputDouble! / self.lhsDouble
        }

    }
    private func mult() {
        self.outputDouble = self.lhsDouble * self.outputDouble
    }
    private func sub() {
        self.outputDouble = self.outputDouble - self.lhsDouble
    }
    private func equal() {
        self.outputDouble = self.lhsDouble + self.outputDouble
    }
    
}