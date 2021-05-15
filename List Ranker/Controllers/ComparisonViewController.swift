//
//  ComparisonViewController.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/11/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit

class ComparisonViewController: UIViewController {
    
    
    
    var unsortedArray: [String] = []
    var sortedArray: [String] = []
    
    var root: Node?
    var currentNode = Node(nameValue: "nil")
    var output: String = ""
    var iterator: Int = 0
    
    var selectedList: SavedList?
    
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedItems = selectedList {
            for items in selectedItems.listItems {
                unsortedArray.append(items)
            }
        }
        
        topButton.isHidden = true
        bottomButton.isHidden = true
        topView.alpha = 0
        bottomView.alpha = 0
        
        topButton.titleLabel?.textAlignment = .center
        bottomButton.titleLabel?.textAlignment = .center
        
        
        
    }
    
    
    // MARK: - Button Configuration
    
    @IBAction func beginRanking(_ sender: UIButton) {
        
        sender.isEnabled = false
        sender.setTitle("Select One", for: .disabled)
        sender.alpha = 0.5
        topView.alpha = 0.75
        bottomView.alpha = 0.75
        topButton.isHidden = false
        topButton.isEnabled = true
        bottomButton.isHidden = false
        bottomButton.isEnabled = true
        
        
        iterator = 0
        
        iterate(value: iterator)
     
    }
    
    
    // Mark: - BinaryTree functions
    
    
    func addNode(name: String){
        
        if self.root == nil {
            
            self.root = Node(nameValue: name)
            self.iterator += 1
            self.iterate(value: iterator)
            
        } else {
            
            self.addNode(name: name, node: root!)
            
        }
        
    }
    
    private func addNode(name: String, node: Node){
        
        topButton.setTitle(name, for: .normal)
        bottomButton.setTitle(node.nodeName, for: .normal)
        showPopUp(name: name, node: node)
        
        
    }
    
    
    func inOrder() -> String{
        self.inOrder(node: self.root!)
        return output
    }
    
    private func inOrder(node: Node){
        if node.leftChild != nil {
            inOrder(node: node.leftChild!)
        }
        sortedArray.append("\(node.nodeName)")
        if node.rightChild != nil {
            inOrder(node: node.rightChild!)
        }
        
    }
    
    
    @IBAction func topButtonPressed(_ sender: Any) {
        if let name = topButton.currentTitle{
            self.output.append("\(name) was selected over \(self.currentNode.nodeName) \r\n")
            if self.currentNode.rightChild == nil {
                
                currentNode.rightChild = Node(nameValue: name)
                
            } else {
                
                
                self.addNode(name: name, node: self.currentNode.rightChild!)
                
            }
            if currentNode.rightChild?.nodeName == name {
                self.iterator += 1
                self.iterate(value: self.iterator)
            }
        }
        
    }
    
    @IBAction func bottomButtonPressed(_ sender: Any) {
        if let name = topButton.currentTitle {
            self.output.append("\(currentNode.nodeName) was selected over \(name) \r\n")
                
                if currentNode.leftChild == nil {
                    
                    
                    currentNode.leftChild = Node(nameValue: name)
                    
                } else {
                    
                    
                    self.addNode(name: name, node: currentNode.leftChild!)
                    
                }
                if currentNode.leftChild?.nodeName == name {
                    self.iterator += 1
                    self.iterate(value: self.iterator)
                }
            }
            
        
    }
    
    func showPopUp(name: String, node: Node){
     
        self.currentNode = node
        
    }
    
    func iterate(value: Int){
        
        if unsortedArray.count > value {
            addNode(name: unsortedArray[value])
            
        } else {
            self.inOrder(node: self.root!)
            self.sortedArray.reverse()
            print(self.sortedArray)
            performSegue(withIdentifier: "goToRanked", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RankedTableViewController {
            
            vc.rankedList = self.sortedArray
        }
    }
}
