//
//  MainViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 11/27/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var titleTextField: UITextField?
    
    @IBOutlet weak var createASurveyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        self.performSegue(withIdentifier: "createASurvey", sender: self)
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
