//
//  LoginViewController.swift
//  Instagram
//
//  Created by Marcus Schumann on 10/9/18.
//  Copyright © 2018 Marcus Schumann. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: AnyObject) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("You're logged in")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }else {
                self.displayLoginErrorAlert()
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground {
            (success: Bool, error: Error?) -> Void in
            if success {
                self.displaySignupSuccessAlert()
            } else {
               self.displaySignupErrorAlert()
            }
        }
    }
   
    
    
    /*----------Display Alert Methods----------*/
    
    // This function is called whenever the sign-in credentials are incorrect. or whenever
    // the sign-up credentials are duplicate, i.e., the user already exists
    func displayLoginErrorAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Login Failed!", message: "Please enter a valid username and password combination.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        // Present the alert and run code to clear the fields in the completing block
        present(alertController, animated: true) {
            self.usernameField.text = ""
            self.passwordField.text = ""
        }
    }
    
    // This function is called whenever the sign-up credentials are duplicate, i.e.,
    // the user already exists in the database
    func displaySignupErrorAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Signup Failed!", message: "That username is already taken. Please choose another one.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        // Present the alert and run code to clear the fields in the completion block
        present(alertController, animated: true) {
            self.usernameField.text = ""
            self.passwordField.text = ""
        }
    }
    
    // The function is called when the user signs-up successfully
    func displaySignupSuccessAlert() {
        // Customize the look and text of the alert controller
        let alertController = UIAlertController(title: "Signup Successful!", message: "New account created.", preferredStyle: .alert)
        // Allow the modal segue to occur when the alert is dismissed
        let dismissAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
        // Present the alert to the user
        alertController.addAction(dismissAction)
        present(alertController, animated: true) { }
    }
    
}
