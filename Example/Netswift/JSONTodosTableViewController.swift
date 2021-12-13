//
//  JSONTodosTableViewController.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class JSONTodosTableViewController: UITableViewController {
    
    var todos: [JSONTodo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.JSONPlaceholder.getAll.perform { result in
            self.todos = result.value
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        guard let todo = todos?[indexPath.row] else {
            return cell
        }
 
        cell.titleLabel.text = todo.title
        cell.completedSwitch.setOn(todo.completed, animated: false)

        return cell
    }
}
