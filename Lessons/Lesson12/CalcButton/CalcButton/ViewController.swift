//
//  ViewController.swift
//  CalcButton
//
//  Created by Rudd Taylor on 2/11/15.
//  Copyright (c) 2015 ga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: CalculatorButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.backgroundColor = UIColor(red: 200/255.0, green: 0, blue: 23/255.0, alpha: 1.0)
        self.button.highlightedColor = UIColor.blueColor()
        self.button.label.text = "1"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

