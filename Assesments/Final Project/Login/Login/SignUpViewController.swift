//
//  SignUpViewController.swift
//  AnyAppLogin
//
//  Created by Matthew Korporaal on 2/19/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpSuccessError: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var loginMessageFromSignUp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidden = true
        spinner.hidesWhenStopped = true
        
        self.username.delegate = self
        self.email.delegate = self
        self.password.delegate = self
        
        self.addTapToDismissKeyboard()
    }
    
    func addTapToDismissKeyboard() {
        var tapToDismissKeyboard = UITapGestureRecognizer(target: self, action: "keyboardDismiss")
        tapToDismissKeyboard.cancelsTouchesInView = false
        self.scrollView.addGestureRecognizer(tapToDismissKeyboard)
    }
    
    func keyboardDismiss() {
        self.touchesBegan(NSSet(), withEvent: UIEvent())
        self.textFieldDidEndEditing(username)
    }
    
    // Jump to next UITextField when Return is tapped
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.username {
            self.email.becomeFirstResponder()
        } else if textField == self.email {
            self.password.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    // Hide keyboard when view is pressed
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.email.resignFirstResponder()
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    // Scroll up when keyboard appears, so text field is not obscured.
    func textFieldDidBeginEditing(textField: UITextField) {
        var scrollTo: CGPoint = CGPointMake(0, self.signUpSuccessError.frame.origin.y)
        UIView.animateWithDuration(0.5) {
        self.scrollView.setContentOffset(scrollTo, animated: true)
        }
    }
    
    // Scroll down when keyboard dismisses
    func textFieldDidEndEditing(textField: UITextField) {
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }

    // Sign up button
    @IBAction func signUpPressed(sender: UIButton) {
    
        // Build the terms and conditions alert
        let alertController = UIAlertController(title: "Agree to terms and conditions", message: "Click 'I Agree' to agree to the End User Licence Agreement.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "I Agree", style: UIAlertActionStyle.Default, handler: { alertController in self.processSignUp(sender)}))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        // Display alert
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    func processSignUp(sender: UIButton) {
        // Create Parse user
        var user = PFUser()
        var userSignedIn: PFUser!
        
        // If all fields are not blank
        if let username = username.text {
            if let email = email.text {
                if let password = password.text {
                    if username != "" && email != "" && password != "" {
                        self.spinner.hidden = false
                        self.spinner.startAnimating()
                        
                        user.username = username
                        user.email = email
                        user.password = password
                        // Log the user in
                        println("before: \(user)")
                        
                        user.signUpInBackgroundWithBlock { (succeeded: Bool!, error: NSError!) in
                            if (error == nil) {
                                // On success, sign in and switch button
                                self.signIn()
                            } else {
                                self.displaySuccessErrorLabel(error.userInfo!.debugDescription, valid: false)
                                self.spinner.stopAnimating()
                            }
                        }
                    } else {
                        self.displaySuccessErrorLabel("All fields must be filled in.", valid: false)
                    }
                }
            }
        }
    }
    
    func signIn() {
        PFUser.logInWithUsernameInBackground(self.username.text, password: self.password.text) { (user: PFUser!, error: NSError!) in
            println("inlogin")
            if let newUser = user {
                // continue with sign in screens
                userSession = newUser
                self.displaySuccessErrorLabel("Success! Click Next.", valid: true)
                self.spinner.stopAnimating()
                dispatch_async(dispatch_get_main_queue()) {
                    // warning: this may push the next VC before user is logged in
                    self.performSegueWithIdentifier("cats", sender: self)
                }
            } else {
                self.displaySuccessErrorLabel(error.localizedDescription, valid: false)
                self.spinner.stopAnimating()
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cats" {
            var categoryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CategoryViewController") as CategoryViewController
            self.navigationController?.pushViewController(categoryViewController, animated: true)
        }
    }
    
    @IBAction func loginPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
//        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func displaySuccessErrorLabel(text: String, valid: Bool) {
        self.signUpSuccessError.text = text
        self.signUpSuccessError.textColor = valid ? UIColor.greenColor() : UIColor.redColor()
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { self.signUpSuccessError.alpha = 1.0 }, completion: { _ in UIView.animateWithDuration(5.0) { self.signUpSuccessError.alpha = 0.0 } })
    }

}
