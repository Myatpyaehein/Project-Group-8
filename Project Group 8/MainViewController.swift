//
//  MainViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/27/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MainViewController: UIViewController {

    var titleTextField: UITextField?
    var surveyID: String?
    
    @IBOutlet weak var createASurveyButton: UIButton!
    @IBOutlet weak var answerSurveyButton: UIButton!
    @IBOutlet weak var mySurveyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func createASurveyPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Create A Survey", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: titleTextField)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: self.submitHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        self.present(alertController, animated: true)
    }
    
    func titleTextField(textField: UITextField!) {
        titleTextField = textField
        titleTextField?.placeholder =  "Please enter the title of your new survey"
    }
    
    func submitHandler(alert: UIAlertAction!) {
        let title = titleTextField?.text
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid
        var ref: DocumentReference? = nil
        ref = db.collection("survey").addDocument(data: [
            "title": title!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.surveyID = ref!.documentID
                db.collection("user").document(id!).getDocument{ (document, error) in
                    if let document = document {
                        var surveyList = document["survey"] as? Array ?? [""]
                        surveyList.append(ref!.documentID)
                        db.collection("user").document(id!).updateData([
                            "survey": surveyList
                            ])
                        self.performSegue(withIdentifier: "createASurvey", sender: self)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createASurvey") {
            let vc = segue.destination as! QuestionViewController
            vc.surveyID = self.surveyID ?? ""
            vc.surveyTitle = (titleTextField?.text)!
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

}
