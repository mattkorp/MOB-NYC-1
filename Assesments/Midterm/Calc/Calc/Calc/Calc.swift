//
//  File.swift
//  Calc
//
//  Created by Matthew Korporaal on 2/15/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation

class Calc {
    
    enum UserMode {
        case Left
        case Right
        case None
    }
    private enum CalcState {
        case Left
        case Right
        case None
    }
    
    private enum CalcCycle {
        case BuildOperand(String)
        case BuildCalculation(String, Double)
        case UnaryCalculation(String, (Double) -> ())
        case BinaryCalculation(String, (Double, Double) -> ())
    }
    
    private var userMode: UserMode
    
    // true if inputting calculation, otherwise false
    private var toggleUserMode: Bool
    
    // for binary calculations
    private var lhsDouble: Double
    private var rhsDouble: Double
    private var binaryOp: Op.Type
    
    // for calculations
    private var digitDouble: Double
    // for display
    private var digitString: String
    {
        didSet {
            // sync double counterpart
            self.digitDouble = (self.digitString as NSString).doubleValue
            // broadcast updates
            NSNotificationCenter.defaultCenter().postNotificationName("DigitUpdated", object: self)
        }
    }
    
    private let operation: Op!
    
    init() {
        
        self.userMode = UserMode.None
        self.toggleUserMode = false
        
        self.digitString = String("0")
        self.digitDouble = Double(0)
        self.lhsDouble = Double(0)
        self.rhsDouble = Double()
        self.operation = Op()
    }
    

    /*
    :method: storeDigit Checks if input is valid.  If valid, digit is converted and saved
    
    :param: digit String value of input
    
    :returns: Optional true or false if invalid digit
    */
    internal func validateDigit(digit: String) -> Bool? {
//        if self.userMode == UserMode.None {
//            self.digitString = "0"
//        }
        if self.toggleUserMode == false {
            self.digitString = "0"
        }
        if digit == "." && (self.digitString.rangeOfString(".") != nil) {
            // Don't add extra ...
            return false
        } else if digit == "0" && self.digitString == "0" {
            // Don't prepend 0000
            return false
        } else if digit != "." && self.digitString == "0" {
            // Drop 0 if first digit
            self.digitString = ""
        }
//        self.userMode = UserMode.Left
        self.toggleUserMode = true
        self.storeDigit(digit)
        return true
    }
    internal func getDigitString() -> String {
        return self.digitString
    }
    private func storeDigit(digit: String) {
        self.digitString += digit
    }
    // TODO: may wnt to add precision argument..
    private func storeDigit(digit: Double, precision: Double) {
        self.digitString = String(format: "%\(precision)f", digit)
    }
    private func resetDigit() {
        self.digitString = "0"
    }
    
    internal func evaluate(value: String) -> String? {
//        var calcCycle = Calc.CalcCycle

        if let op = operation.fromRaw(value) {
            println("\(value): op: \(op), operation: \(operation) toRaw: \(op.rawValue)")
            switch op {
            case .AllClear:
                self.resetDigit()
            case .Parity:
                self.toggleParity()
            case .Sqrt:
                self.sqRoot()
            case .Percent:
                self.percent()
//            case .Divide:
//                self.div()
//            case .Multiply:
//                self.mult()
//            case .Subtract:
//                self.sub()
//            case .Add:
//                self.add(operation)
//            case .Equal:
//                self.equal()
            default:
                return nil
            }
        }
        return nil
    }
    
    private func toggleParity() {
        if self.digitDouble > 0 {
            self.digitString = "-" + self.digitString
        } else {
            self.digitString = self.digitString.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
    }
    private func sqRoot() {
        self.digitDouble = sqrt(self.digitDouble)
        self.storeDigit(self.digitDouble, precision: 0.6)
        self.toggleUserMode = false
    }
    
    private func percent() {
        self.digitDouble /= 100
        self.storeDigit(self.digitDouble, precision: 0.2)
        self.toggleUserMode = false
    }
    
    private func add(currentOp: Op) {
        if self.userMode == UserMode.Left {
            self.lhsDouble = self.digitDouble
            self.binaryOp = currentOp
            self.userMode = UserMode.Right
        } else if self.userMode == UserMode.Right {
            
        } else {
            
        }
        if self.digitDouble != 0 && self.toggleUserMode == true {
            
        }
    }

}