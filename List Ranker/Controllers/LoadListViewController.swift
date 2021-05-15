//
//  LoadListViewController.swift
//  List Ranker
//
//  Created by Daniel Rivera on 5/6/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit
import RealmSwift

class LoadListViewController: UITableViewController {

    
    var loadedList = SavedList()
    var listToArray: [String] = []
    var listName = ""
    
    var index = 0
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listName = loadedList.listName
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loadedList.listItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let rankedNumber: Int = indexPath.row + 1
        let cellTitle: String = "\(rankedNumber) - \(self.loadedList.listItems[indexPath.row])"
        
        cell.textLabel?.text = cellTitle
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //delete button
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            
            do{
                try self.realm.write {
                    self.loadedList.listItems.remove(at: indexPath.row)
                }
            } catch {
                print("error in deleting selected row. \(error)")
            }
            
            tableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
            
            completionHandler(true)
            
        }
        
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash")
        
        
        //edit
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
        
            self.index = indexPath.row
            self.addItem(update: true, text: self.loadedList.listItems[indexPath.row])
            
        }
        
        edit.backgroundColor = .black
        edit.image = UIImage(systemName: "pencil")
            
        
        //swipe
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
    }
    
    //MARK: - Bar Buttons
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func rankButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToRank", sender: self)
        
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
      addItem(update: false, text: "")
         
    }
    
    func addItem(update: Bool, text: String){
     
        let alertController = UIAlertController(title: "ADD LIST ITEM", message: "Please enter a new list item.", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
        
            UITextField.placeholder = "Add List Item"
        }
        
        alertController.textFields![0].text = text
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let enteredText = alertController.textFields![0] as UITextField
            if let text = enteredText.text{
            
                if update == false {
                    self.addToRealm(text: text)
                } else if update == true {
                    self.updateRealm(text: text)
                }
                self.tableView.reloadData()
            }
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ComparisonViewController{
            vc.selectedList = loadedList
        }
    }
    
    
    
    //MARK: - Update Realm List
    
    func addToRealm(text: String){
        
        
        let updateList = realm.objects(SavedList.self)
        
        for lists in updateList {
            if lists.listName == loadedList.listName{
                
                
                do {
                    try realm.write {
                        lists.listItems.append(text)
                    }
                    
                } catch  {
                    print("Error adding new item to Realm from LoadListViewController \(error)")
                }
            }
        }
    
    }
    
    func updateRealm(text: String){
        
        let updateList = realm.objects(SavedList.self)
        
        for lists in updateList {
            if lists.listName == loadedList.listName{
                
                
                do {
                    try realm.write {
                        lists.listItems.replace(index: index, object: text)
                    }
                    
                } catch  {
                    print("Error updating Realm from LoadListViewController \(error)")
                }
            }
        }
    }
    
    
}
