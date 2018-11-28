//
//  TableViewController.swift
//  Project Group 8
//
//  Created by Feiyu Cai on 10/9/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    var questionString: String?
    var answer: [String]?
}
class QuestionViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: <#T##IndexPath#>)
        cell.textLabel?.text = 
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
}
