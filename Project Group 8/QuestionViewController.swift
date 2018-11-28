//
//  TableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 10/9/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UITableViewController {
    
    var questions = ["Do you like cat or dog?", "Number of pet you have"]
    
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    @IBAction func addNewQuestion(_ sender: UIBarButtonItem) {
        questions += ["Untitled"]
        tableView.reloadData()
    }
    
    
}
