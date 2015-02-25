//
//  ViewController.swift
//  AnyAppLogin
//
//  Created by Matthew Korporaal on 2/19/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginSuccessErrorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.spinner.hidden = true
        self.spinner.hidesWhenStopped = true
        
        username.delegate = self
        password.delegate = self
        
        var tapToDismissKeyboard = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tapToDismissKeyboard.cancelsTouchesInView = false
        self.scrollView.addGestureRecognizer(tapToDismissKeyboard)
        
    }

    func dismissKeyboard() {
        self.touchesBegan(NSSet(), withEvent: UIEvent())
        self.textFieldDidEndEditing(username)
    }
    
    @IBAction func loginButton(sender: UIButton) {
        self.spinner.hidden = false
        self.spinner.startAnimating()
        PFUser.logInWithUsernameInBackground(self.username.text, password: self.password.text) {
            (user: PFUser!, error: NSError!) in
            if user != nil {
                // TODO: Go to main UI
            } else {
                self.spinner.stopAnimating()
                self.displaySuccessErrorLabel("Invalid login credentials. Try again.", valid: false)
            }
        }
    }

//    @IBAction func skipToSignupButton(sender: UIButton) {
//        self.performSegueWithIdentifier("signup", sender: self)
//    }
    @IBAction func skipToAppButton(sender: UIButton) {
        // TODO: go to main UI without user
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displaySuccessErrorLabel(text: String, valid: Bool) {
        self.loginSuccessErrorLabel.text = text
        self.loginSuccessErrorLabel.textColor = valid ? UIColor.greenColor() : UIColor.redColor()
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { self.loginSuccessErrorLabel.alpha = 1.0 }, completion: { _ in UIView.animateWithDuration(5.0) { self.loginSuccessErrorLabel.alpha = 0.0 } })
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "signup" {
//            var signUpVC = segue.destinationViewController as SignUpViewController
////            self.navigationController?.pushViewController(signUpVC, animated: true)
//        }
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.username {
            self.password.becomeFirstResponder()
        } else {
            // TODO: Change this to LoginPressed
            textField.resignFirstResponder()
        }
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var scrollTo: CGPoint = CGPointMake(0, self.loginSuccessErrorLabel.frame.origin.y)
        UIView.animateWithDuration(0.5) {
            self.scrollView.setContentOffset(scrollTo, animated: true)
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    
}

