//
//  addQuestionPopupViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/27/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit

class addQuestionPopupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var choices = ["0", "1", "2", "More than 2"]

    @IBOutlet weak var ChoicesTableView: UITableView!
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoicesCell", for: indexPath)
        cell.textLabel?.text = choices[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            choices.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//
//        }
//    }

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var questionNumStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        var questionNum = 0
        questionNum = Int(sender.value)
        questionNumLabel.text = "Options: " + String(questionNum)
    }
  
}

