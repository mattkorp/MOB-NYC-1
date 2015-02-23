//
//  ViewController.swift
//  AnyAppLogin
//
//  Created by Matthew Korporaal on 2/19/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
protocol LoginViewControllerDelegate {
    var loginMessageFromSignUp: String { get }
}
class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginSuccessErrorLabel: UILabel!

//    var delegate: SignUpViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButton(sender: UIButton) {
        
    }
    @IBAction func signUpButton(sender: UIButton) {
        
    }
    @IBAction func skipToAppButton(sender: UIButton) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signUp" {
            var signUpVC = SignUpViewController()
            
            signUpVC = segue.destinationViewController as! SignUpViewController
            signUpVC.delegate = self
        }
    }

}

