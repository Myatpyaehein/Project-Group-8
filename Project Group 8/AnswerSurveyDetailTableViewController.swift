//
//  SurveyDetailTableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/28/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import FirebaseFirestore
class AnswerSurveyDetailTableViewController: UITableViewController {

    var surveyID: String?
    var surveyTitle: String?
    var options = [[String]]()
    var question = [String]()
    var optionResult = [String: [Int]]()
    var selectedOptions = [String: Int]()
    var newOptionResult = [String: [Int]]()
    @IBOutlet weak var submitSurveyAnswerButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = surveyTitle
        tableView?.allowsMultipleSelection = true
        print("ID: " + surveyID!)
        let db = Firestore.firestore()
        db.collection("survey").document(self.surveyID!).getDocument() { (document, err) in
            if let document = document {
                self.question = document.data()!["question"] as! [String]
                let optionsDic = document.data()!["options"] as! [String: [String]]
                self.optionResult = document.data()!["optionsResult"] as! [String: [Int]]
                for key in optionsDic.keys {
                    self.options.append(optionsDic[key]!)
                }
                self.tableView.reloadData()
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return question.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return question[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOptions[String(indexPath.section)] = indexPath.row
        print(type(of: indexPath.section))
        print(String(indexPath.section) + " " + String(indexPath.row))
        print(selectedOptions)
    }
    
    @IBAction func submitSurveyButtonPressed(_ sender: UIBarButtonItem) {
        if (self.question.count != self.selectedOptions.count) {
            let error = "Please select one option for every question"
            let alertController = UIAlertController(title: "Submission failed", message: error, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
        else {
            for key in self.optionResult.keys {
                var array = self.optionResult[key]
                var newArray = [Int]()
                for index in 0...(array!.count-1) {
                    if (index != self.selectedOptions[key])
                    {
                        newArray.append(array![index])
                    } else {
                        newArray.append(array![index] + 1)
                    }
                }
                self.newOptionResult[key] = newArray
            }
            print(self.optionResult)
            print(self.newOptionResult)
        }
        
        let db = Firestore.firestore()
        db.collection("survey").document(self.surveyID!).updateData([
            "optionsResult": newOptionResult
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.performSegue(withIdentifier: "finishedAnswering", sender: self)
            }
        }
    }
}

