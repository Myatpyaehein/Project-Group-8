//
//  AuthViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 10/21/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthViewController: UIViewController {

    
    @IBOutlet weak var authSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn: Bool = true
    
    @IBAction func authSelectorChange(_ sender: UISegmentedControl) {
        isSignIn = !isSignIn
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        //TODO: form validation on the email and password
        
        //
        if let email = emailTextField.text, let password = passwordTextField.text {
        
            //sign In
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    // check that user is not nil
                    if let u = user {
                        //user if found
                        self.performSegue(withIdentifier: "signInTester", sender: self)
                    } else {
                        //ERROR: user if not found
                    }
                })
            }
            //register
            else {
                Auth.auth().createUser(withEmail: email, password: password, completion:  { (authResult, error) in
                    // check that user is not nil
                    if let u = authResult {
                        //user if found
                        self.performSegue(withIdentifier: "signInTester", sender: self)
                    } else {
                        //ERROR: user if not found
                    }
                })
//                    guard let user = authResult?.user else { return }
                }
                
            }
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
