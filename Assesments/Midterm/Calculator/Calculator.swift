//
//  Calculator.swift
//  Calculator
//
//  Created by Matthew Korporaal on 2/10/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation
import UIKit

class Calculator {
    
    // TODO: replace inInputState with this
    enum InputState {
        case Digit, Operation, Evaluation
    }
    
    var operation: String = ""

    func digitPressed(digit: String) {
        // append digit to stack
    }
}