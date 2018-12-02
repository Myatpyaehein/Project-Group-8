//
//  MySurveyDetailTableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 12/2/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MySurveyDetailTableViewController: UITableViewController {

    var surveyID: String?
    var surveyTitle: String?
    var questionAnswers = [[String]]()
    var question = [String]()
    var optionsReuslt = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = surveyTitle
        print("ID: " + surveyID!)
        let db = Firestore.firestore()
        db.collection("survey").document(self.surveyID!).getDocument() { (document, err) in
            if let document = document {
                self.question = document.data()!["question"] as! [String]
                let optionsDic = document.data()!["options"] as! [String: [String]]
                let optionsReusltDic = document.data()!["optionsResult"] as! [String: [Int]]
                for key in optionsDic.keys {
                    self.questionAnswers.append(optionsDic[key]!)
                }
                for key in optionsReusltDic.keys {
                    self.optionsReuslt.append(optionsReusltDic[key]!)
                }
                print(optionsDic)
                self.tableView.reloadData()
            } else {
                print("Document does not exist in cache")
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Table view data source
    
    //    var questionAnswers = [["Cats", "Dogs"], ["0", "1", "2", "More than 2"]]
    //    var question = ["Do you like cats or dogs?","How many pets do you have"]
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return question.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionAnswers[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)
        cell.textLabel?.text = questionAnswers[indexPath.section][indexPath.row]
        cell.detailTextLabel?.text = "VOTE: " + String(optionsReuslt[indexPath.section][indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return question[section]
    }

}
