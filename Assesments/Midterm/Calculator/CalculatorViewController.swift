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
    
//    override func loadView() {
//        // assign self.view to below?
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.loadDisplay(self.view)

    }
    
    // MARK: Targets set in CalculatorView
    func digitPressed(sender: UIButton) {
        // add digit to calculator model and update view
        println("num: \(sender.currentTitle!)")
        calculatorView.updateDisplayOutput(Character(sender.currentTitle!))
//        calculator.digitPressed(sender)
    }
    
    func operationPressed(sender: UIButton) {
        println("op: \(sender.currentTitle!)")
        // Do NOT update CalcView
        
        // set op locally, can change if another op is chosen
    }
    
    func evaluatePressed() {
        println("evaluating..")

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
