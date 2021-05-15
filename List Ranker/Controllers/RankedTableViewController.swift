//
//  RankedTableViewController.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/24/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit
import RealmSwift

class RankedTableViewController: UITableViewController {
    
    var rankedList:[String] = []
    
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
        return rankedList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        let rankNumber: Int = indexPath.row + 1
        
        let cellTitle: String = "\(rankNumber) - \(self.rankedList[indexPath.row])"
        
        cell.textLabel?.text = cellTitle
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        
        return cell
    }
    
    
    
    // MARK: - Bar Buttons Pressed
    
    @IBAction func exitBarButtonPressed(_ sender: Any) {
        
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Save Ranked List", message: "Do you wish to save your ranked list?", preferredStyle: .alert)
        
        alert.addTextField { (text) in
            text.placeholder = "Type in List Name"
        }
        let action = UIAlertAction(title: "Save List", style: .default) { (action) in
            
            let enteredText = alert.textFields![0]
            
            if enteredText.text?.isEmpty == false {
                
                let newList = SavedList()
                newList.listName = enteredText.text!
                
                for item in self.rankedList {
                    newList.listItems.append(item)
                }
                
                do {
                    let realm = try Realm()
                    
                    realm.beginWrite()
                    realm.add(newList)
                    try realm.commitWrite()
                    
                
                    self.savedAlert()
                    
                } catch {
                    print("Error with Realm. \(error)")
                }
                
                
            }
        }
        
        action.isEnabled = false
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            self.dismiss(animated: true, completion: nil)
        }
        
        //Notification to check if the textbox has something entered in the field.
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields![0], queue: OperationQueue.main) { (Notification) in
            
            if alert.textFields![0].text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ==  false {
            action.isEnabled = true
            } else {
                action.isEnabled = false
            }
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func savedAlert() {
        let saveAlert = UIAlertController(title: "List Saved", message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel) { (cancel) in
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
        
        saveAlert.addAction(cancel)
        present(saveAlert, animated: true, completion: nil)
    }
    
}
