//
//  SelectSurveyTableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/28/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SelectSurveyTableViewController: UITableViewController {

    var surveiesTitle = [String]()
    var surveiesID = [String]()
    var surveyID: String?
    var surveyTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("survey").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.surveiesID.append(document.documentID)
                    let tempID = document.data()["creator"] as! String
                    if (tempID != (uid)) {
                        self.surveiesTitle.append(document.data()["title"] as! String)
                    }
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
            let vc = segue.destination as! AnswerSurveyDetailTableViewController
            vc.surveyID = self.surveyID ?? ""
            vc.surveyTitle = self.surveyTitle ?? ""
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
