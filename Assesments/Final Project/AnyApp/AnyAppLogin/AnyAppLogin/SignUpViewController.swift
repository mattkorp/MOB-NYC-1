//
//  SignUpViewController.swift
//  AnyAppLogin
//
//  Created by Matthew Korporaal on 2/19/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, LoginViewControllerDelegate {
    @IBOutlet weak var signUpSuccessError: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var loginMessageFromSignUp: String = ""
    var delegate: LoginViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func signUpButtonPressed(sender: UIButton) {
        var user = PFUser()
        
        if let username = username.text, email = email.text, password = password.text {
            user.username = username
            user.email = email
            user.password = password
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    self.loginMessageFromSignUp = "Sign Up Complete."
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    let err = error.userInfo
                }
                
            }
        } else {
            signUpSuccessError.text = "All Fields Must Be Filled."
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
