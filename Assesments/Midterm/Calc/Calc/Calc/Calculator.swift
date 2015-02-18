//
//  Calculator.swift
//  Calc
//
//  Created by Matthew Korporaal on 2/17/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation

class Calculator {
    
    private enum Op: Printable {
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, Double, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .UnaryOperation(let symbol, _ ):
                    return symbol
                case .BinaryOperation(let symbol, _, _ ):
                    return symbol
                }
            }
        }
    }
    
    private var operandStack = [Double]()
    private var operationStack = [Op]()
    private var operations = [String:Op]()
    private let calculatorKeys = Ops().getCalcKeys()

    // for display
    var result: Double = 0.0
    {
        didSet {
            // broadcast updates
            NSNotificationCenter.defaultCenter().postNotificationName("DigitUpdated", object: self)
        }
    }
    
    init() {
        func buildOperation(op: Op) {
            operations[op.description] = op
        }
        let mdSeed = 1.0
        let asSeed = 0.0
        buildOperation(Op.BinaryOperation("×", mdSeed, *))
        buildOperation(Op.BinaryOperation("÷", mdSeed) { $1 / $0 })
        buildOperation(Op.BinaryOperation("+", asSeed, +))
        buildOperation(Op.BinaryOperation("−", asSeed) { $1 - $0 })
        buildOperation(Op.UnaryOperation("√", sqrt))
        buildOperation(Op.UnaryOperation("%") { $0 / 100 })
        buildOperation(Op.UnaryOperation("±") { -$0 })
    }

    private func evaluate(ops: [Op], rands: [Double]) -> (result:Double?, remainingOps:[Op], remainingRands:[Double]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            var remainingVars = rands
            
            switch remainingOps.removeLast() {
            case .UnaryOperation(_, let operation):
                let operand = remainingVars.removeLast()
                self.clearAll()
                return (operation(operand), remainingOps, remainingVars)
                
                
            case .BinaryOperation(_, let seed, let operation):
                var operand1: Double, operand2: Double
                operand2 = remainingVars.removeLast()
                println("else op2: \(operand2)")
                let eval = evaluate(remainingOps, rands: remainingVars)
                if eval.result != nil {
                    operand1 = eval.result!
                } else {
                    operand1 = seed
                }
                println("op1:\(operand1) op2:\(operand2) Vars:\(remainingVars) Ops:\(remainingOps) ")
                return (operation(operand1, operand2), remainingOps, remainingVars)
            }
        }
        
        return (nil, ops, rands)
    }
    
    func pushOperand(operand: Double) {
        operandStack.append(operand)
    }
    
    func pushOperation(symbol: String) {
        let key = calculatorKeys[symbol]
        if key == "clear" {
            self.clearAll()
        }
        else if key == "binary" && operandStack.count == 1{
            return
        } else if key != "equal" {
            if let operation = operations[symbol] {
                if operationStack.count == 0 {
                    operationStack.append(operation)
                }
                operationStack.append(operation)
                if let result = evaluate() {
                    self.result = result
                }
            }
        } else {
            if let result = evaluate() {
                self.result = result
            }
        }
    }

    func clearAll() {
        self.operandStack.removeAll(keepCapacity: false)
        self.operationStack.removeAll(keepCapacity: false)
        self.result = 0
    }
    
    func evaluate() -> Double? {
        let (result, operators, operands) = evaluate(operationStack, rands: operandStack)
        return result
    }
}