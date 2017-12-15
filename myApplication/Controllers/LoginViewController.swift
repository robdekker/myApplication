//
//  LoginViewController.swift
//  myApplication
//
//  Created by Rob Dekker on 06-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginToList", sender: nil)
            }
        }
    }
    
    // Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Register new account",
                                      message: "Please enter your email and password below.",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
          style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            if !self.isValidEmail(email: emailField.text!) {
                
                let alert = UIAlertController(title: "Please give a valid email",
                                              message: "Example: example@example.com",
                                              preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try again",
                                             style: .default)
                alert.addAction(tryAgain)
                
                self.present(alert, animated: true, completion: nil)
                
            } else if passwordField.text!.characters.count < 6 {

                let alert = UIAlertController(title: "Please fill in a valid password.",
                                              message: "Your password must be at least 6 characters.",
                                              preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try again",
                                             style: .default)
                alert.addAction(tryAgain)
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                Auth.auth().createUser(withEmail: emailField.text!,
                                       password: passwordField.text!) { user, error in
                                        if error == nil {
                                            Auth.auth().signIn(withEmail: self.emailTextField.text!,
                                                               password: self.passwordTextField.text!)
                                        }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Email"
            textEmail.keyboardType = .emailAddress
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Functions
    
    // Check if email is valid, used example from stackoverflow
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
