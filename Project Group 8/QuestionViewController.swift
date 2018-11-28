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
    
    var questions = ["Do you like cats or dogs?", "Number of pets you have"]
    
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
//        questions += ["Untitled"]
//        tableView.reloadData()
        self.performSegue(withIdentifier: "addQuestion", sender: self)
    }
    
    
}
