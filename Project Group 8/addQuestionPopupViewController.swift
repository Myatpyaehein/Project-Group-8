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

protocol addQuestionProtocol: class {
    func passData(question: String, option: [String])
}

class addQuestionPopupViewController: UIViewController {
    
    var question = ""
    var option = [String]()
    var delegate: addQuestionProtocol?
    
    
    @IBOutlet weak var submitQuestionButton: UIButton!
    @IBAction func submitQuestionPressed(_ sender: UIButton) {
        if questionTextField.text != "" {
            question = (questionTextField?.text)!
            if option1TextField?.text != ""{
                option.append((option1TextField?.text)!)
            }
            if option2TextField?.text != ""{
                option.append((option2TextField?.text)!)
            }
            if option3TextField?.text != ""{
                option.append((option3TextField?.text)!)
            }
            if option4TextField?.text != ""{
                option.append((option4TextField?.text)!)
            }
            delegate?.passData(question: question, option: option)
            DataManager.shared.firstVC.tableView.reloadData()
            dismiss(animated: true, completion: nil)
        } else {
            print ("question is empty")
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

