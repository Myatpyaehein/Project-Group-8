//
//  TableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 10/9/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore


class QuestionViewController: UITableViewController, addQuestionProtocol {
    
    var surveyID = ""
    var surveyTitle = ""
    var questions = [String]()
    var options = [String: [String]]()
    var optionsResult = [String: [Int]]()
    
    @IBOutlet var surveyQuestionTableView: UITableView!
    
    func passData(question: String, option: [String]) {
        var optionsResultHolder = [Int]()
        self.questions.append(question)
        self.options[String(questions.count - 1)] = option
        for _ in option {
          optionsResultHolder.append(0)
        }
        self.optionsResult[String(questions.count - 1)] = optionsResultHolder
        print(self.questions)
        print(self.options)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = surveyTitle
        DataManager.shared.firstVC = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsCell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            questions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    @IBAction func addNewQuestion(_ sender: UIBarButtonItem) {
       self.performSegue(withIdentifier: "addQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? addQuestionPopupViewController {
            vc.delegate = self
        }
    }
    
    @IBOutlet weak var submitSurveyButton: UIBarButtonItem!
    
    @IBAction func submitSurveyButtonPressed(_ sender: UIBarButtonItem) {
        let db = Firestore.firestore()
        db.collection("survey").document(self.surveyID).setData([
            "title": self.surveyTitle,
            "question": self.questions,
            "options": self.options,
            "optionsResult": self.optionsResult
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    self.performSegue(withIdentifier: "finishedAddedSurvey", sender: self)
                }
        }
    }
}

class DataManager {
    static let shared = DataManager()
    var firstVC = QuestionViewController()
}
