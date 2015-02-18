//
//  File.swift
//  Calc
//
//  Created by Matthew Korporaal on 2/15/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation

class Calc {
    
    //private let calcKeys: OrderedDictionary<String, String> = Op().getCalcKeys()
    // Store the operations and operands
    private var opStack: [Op] = []
    // for calculations
    private var outputDouble: Double
    // for display
    private var outputString: String
    {
        didSet {
            // sync double counterpart and update stack
            outputDouble = (outputString as NSString).doubleValue
            //opStack[opStack.count] = self.outputString
            // broadcast updates
            NSNotificationCenter.defaultCenter().postNotificationName("DigitUpdated", object: self)
        }
    }
    
    private var knownOps = [String:Op]()
    
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _ ):
                    return symbol
                case .BinaryOperation(let symbol, _ ):
                    return symbol
                }
            }
        }
    }
    
    init() {
    
        
//        func learnOp(op: Op) {
//            knownOps[op.description] = op
//        }
//        
//        learnOp(Op.BinaryOperation("×", *))
//        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
//        learnOp(Op.BinaryOperation("+", +))
//        learnOp(Op.BinaryOperation("−") { $1 - $0 })
//        learnOp(Op.UnaryOperation("√", sqrt))
        self.outputDouble = 0.0
        self.outputString = "0"
//        self.resetOutput()
    }
    
    private func evalute(ops: [Op]) -> (result:Double?, remainingOps:[Op]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            
            switch remainingOps.removeLast() {
                
            case .Operand(let operand):
                return (operand, remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evalute(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evalute(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evalute(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
            
        }
        
        return (nil, ops)
    }
    
    func evalute() -> Double? {
        let (result, reminder) = evalute(opStack)
        println("\(result),\(reminder)")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evalute()
    }
    
    func performOperation(symbol: String) -> Double? {
//        if let operation = Ops().fromRaw(symbol) {
//            switch operation {
//            case .Parity:
//                self.toggleParity()
//            case .Sqrt:
//                self.sqRoot()
//            case .Percent:
//                self.percent()
//            case .Divide:
//                self.div()
//            case .Multiply:
//                self.mult()
//            case .Subtract:
//                self.sub()
//            case .Add:
//                self.add()
//            case .Equal:
//                self.equal()
//            default:
//                return 0.0
//            }
//        }
        if let operation = knownOps[symbol] {
            
            opStack.append(operation)
        }
        return evalute()
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
    
    internal func pushOperand(value: String) {
        self.outputDouble = (self.outputString as NSString).doubleValue
        opStack.append(Op.Operand(self.outputDouble))

    }
    
//    internal func evaluate(value: String) {
//        let keyCategory: String = self.calcKeys[value]!
//        switch keyCategory {
//        case "unary":
//            self.evaluateUnary(value)
//        case "binary":
//            // One operand, add operator
//            if opStack.count == 1 {
//                opStack.append(value)
//            // Replace operator
//            } else if opStack.count == 2 {
//                opStack[opStack.count] = value
//                self.evaluateBinary(value)
//            } else if opStack.count == 3 {
//                self.evaluateBinary(value)
//            }
//        case "clear":
//            self.opStack.removeAll(keepCapacity: false)
//            self.resetOutput()
//        default:
//            return
//        }
//    }

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

//    private func evaluateUnary(op: String) {
//        if let unary = Op().fromRaw(op) {
//            switch unary {
//            case .Parity:
//                self.toggleParity()
//            case .Sqrt:
//                self.sqRoot()
//            case .Percent:
//                self.percent()
//            default:
//                return
//            }
//        } else {
//            println("Cannot handle this operation")
//        }
//    }
//    private func evaluateBinary(op: String) {
//        if let binary = Op().fromRaw(op) {
//            switch binary {
//            case .Divide:
//                self.div()
//            case .Multiply:
//                self.mult()
//            case .Subtract:
//                self.sub()
//            case .Add:
//                self.add()
//            case .Equal:
//                self.equal()
//            default:
//                return
//            }
////            self.operation = op
//            self.storeDigit(self.outputDouble, precision: 0.6)
//        } else {
//            println("Cannot handle this operation")
//        }
//    }
    
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
        self.outputDouble /= 100.0
        self.storeDigit(self.outputDouble, precision: 0.2)
    }
    
    // MARK: Binary Methods
    private func add() {
    }
    private func div() {

    }
    private func mult() {
    }
    private func sub() {
    }
    private func equal() {
    }
    
}