//
//  addQuestionPopupViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/27/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol addQuestionProtocol {
    func passData(question: String, options: [String])
}

class addQuestionPopupViewController: UIViewController {
    
    var addQuestionProtocol: addQuestionProtocol?
    var question = ""
    var options = [String]()
    @IBOutlet weak var submitQuestionButton: UIButton!
    @IBAction func submitQuestionPressed(_ sender: UIButton) {
        if questionTextField.text != "" {
            let question = questionTextField?.text
            if option1TextField?.text != ""{
                options.append((option1TextField?.text)!)
            }
            if option3TextField?.text != ""{
                options.append((option2TextField?.text)!)
            }
            if option4TextField?.text != ""{
                options.append((option3TextField?.text)!)
            }
            if option4TextField?.text != ""{
                options.append((option4TextField?.text)!)
            }
        } else{
            
        }
        dismiss(animated: true)
        if let presenter = presentingViewController as? QuestionViewController {
            presenter.newQuestion = self.question
            presenter.newOptions = self.options
        }
    }

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
    @IBOutlet weak var option3TextField: UITextField!
    @IBOutlet weak var option4TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

