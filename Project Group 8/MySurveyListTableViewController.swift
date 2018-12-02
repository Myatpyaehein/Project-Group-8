//
//  MySurveyListTableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 12/2/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MySurveyListTableViewController: UITableViewController {
    
    var surveiesTitle = [String]()
    var surveiesID = [String]()
    var surveyID: String?
    var surveyTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("survey").whereField("creator", isEqualTo: uid!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.surveiesID.append(document.documentID)
                    self.surveiesTitle.append(document.data()["title"] as! String)
                }
                self.tableView.reloadData();
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveiesTitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveiesCell", for: indexPath)
        cell.textLabel?.text = surveiesTitle[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.surveyID = surveiesID[indexPath.row]
        self.surveyTitle = surveiesTitle[indexPath.row]
        self.performSegue(withIdentifier: "openSurvey", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "openSurvey") {
            let vc = segue.destination as! MySurveyDetailTableViewController
            vc.surveyID = self.surveyID ?? ""
            vc.surveyTitle = self.surveyTitle ?? ""
        }
    }

}
