//
//  ForgetPassViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/26/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func emailSubmitPressed(_ sender: UIButton) {
        if let email = emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: email)
            { error in
                if let error = error {
                    let alertController = UIAlertController(title: "Request error", message: error as? String , preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Back", style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Request submited", message: "your password request successfully sent", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Back", style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true)
                    self.performSegue(withIdentifier: "BackToAuthorization", sender: self)
                }
            }
        }
    }
}
