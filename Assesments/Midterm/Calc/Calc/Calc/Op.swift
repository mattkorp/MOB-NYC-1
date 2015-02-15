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
    
//    enum Ops: String {
//        case AllClear = "AC"
//        case Parity = "±"
//        case Sqrt(String, Double -> Double)
//        case Percent(String, Double -> Double)
//        case Divide(String, (Double, Double) -> Double)
//        case Multiply(String, (Double, Double) -> Double)
//        case Subtract(String, (Double, Double) -> Double)
//        case Add(String, (Double, Double) -> Double)
//        case Equal(String, (Double, Double) -> Double)
//    }
    
    func fromRaw(raw: String) -> Operation? {
        return Operation(rawValue: raw)
    }
    
    func toRaw() -> String? {
        return ""
    }
}