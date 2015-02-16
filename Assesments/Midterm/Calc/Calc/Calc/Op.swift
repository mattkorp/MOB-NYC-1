//
//  Config.swift
//  Calculator
//
//  Created by Matthew Korporaal on 2/12/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation

protocol RawOperations {
    typealias Operation: RawRepresentable
    func fromRaw(raw: String) -> Operation?
    func toRaw() -> String?
}

struct Op: RawOperations {
    
    enum Operation: String {
        case AllClear = "AC"
        case Parity = "±"
        case Sqrt = "√"
        case Percent = "%"
        case Divide = "÷"
        case Multiply = "×"
        case Subtract = "−"
        case Add = "+"
        case Equal = "="
    }
    
    private var calcKeys = OrderedDictionary<String, String>(
        keys: ["AC","±","%","÷",
            "7","8","9","×",
            "4","5","6","−",
            "1","2","3","+",
            "0",".","√","=" ],
        values: ["clear","unary","unary","binary",
            "digit","digit","digit","binary",
            "digit","digit","digit","binary",
            "digit","digit","digit","binary",
            "digit","digit","unary","equal"])
    
    internal func getCalcKeys() -> OrderedDictionary<String, String> {
        return self.calcKeys
    }
    
    internal func fromRaw(raw: String) -> Operation? {
        return Operation(rawValue: raw)
    }
    
    // Dummy function needed for RawOperations
    internal func toRaw() -> String? {
        return nil
    }
}