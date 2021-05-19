//
//  ListEntryTableViewController.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/11/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit

class ListEntryTableViewController: UITableViewController {

    var listArray: [String] = []
    var index: Int = 0
    var ipath = IndexPath()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = listArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Delete
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            
            self.listArray.remove(at: indexPath.row)
            
            tableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
            
            completionHandler(true)
        }
        
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash")
        
        
        
        //edit
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            
            self.index = indexPath.row
            self.ipath = indexPath
            self.addText(update: true, Text: self.listArray[indexPath.row])
    
            
        }
        
        edit.backgroundColor = .black
        edit.image = UIImage(systemName: "pencil")
        
        //swipe
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
    }

    //MARK: - Bar Buttons
    
    @IBAction func backBarButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func rankListBarButton(_ sender: UIBarButtonItem) {
        
        if self.listArray.isEmpty == true {
            let alert = UIAlertController(title: "Missing Information", message: "You need to enter an item into the list", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        } else {
        
        performSegue(withIdentifier: "gotoCompare", sender: self)
        
        }
    }
    
    
    @IBAction func addListItemBarButton(_ sender: UIBarButtonItem) {
        
        addText(update: false, Text: "")
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ComparisonViewController{
            vc.unsortedArray = listArray
        }
    }
    
    func addText(update: Bool, Text: String) {
        
        let alertController = UIAlertController(title: "ADD LIST ITEM", message: "Please enter a new list item.", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
        
            UITextField.placeholder = "Add List Item"
        }
        
        alertController.textFields![0].text = Text
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let enteredText = alertController.textFields![0] as UITextField
            if let text = enteredText.text{
                
                if update == false {
            
                self.listArray.append(text)
                self.tableView.reloadData()
                } else if update == true {
                    self.listArray[self.index] = text
                    self.tableView.reloadRows(at: [self.ipath], with: .fade)
                }
            }
            
            self.tableView.reloadData()
            
        }
        
        okAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        //Notification to check if the textbox has text in it
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alertController.textFields![0], queue: OperationQueue.main) { (Notification) in
            
            if alertController.textFields![0].text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false  {
            okAction.isEnabled = true
            } else {
                okAction.isEnabled = false
            }
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
