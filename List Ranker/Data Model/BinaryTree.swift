//
//  BinaryTree.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/11/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import Foundation

class BinaryTree{
    
    var root: Node?
    var output: String = ""
    func addNode(name: String, number: Int){
        
        if self.root == nil {
        
            self.root = Node(nameValue: name)
        
        } else {
        
            self.addNode(name: name, node: root!, number: number)
        
        }
        
    }
    
    private func addNode(name: String, node: Node, number: Int){
        
        
        if number == 0 {
            output.append("\(name) was selected over \(node.nodeName) \r\n")
            if node.rightChild == nil {
                node.rightChild = Node(nameValue: name)
            } else {
                self.addNode(name: name, node: node.rightChild!, number: number)
            }
        } else {
            output.append("\(node.nodeName) was selected over \(name) \r\n")
            if node.leftChild == nil {
                node.leftChild = Node(nameValue: name)
                
            } else {
                self.addNode(name: name, node: node.leftChild!, number: number)
            }
        }
    }
    
    func inOrder() -> String{
        self.inOrder(node: self.root!)
        return output
    }
    
    private func inOrder(node: Node){
        if node.leftChild != nil {
            inOrder(node: node.leftChild!)
        }
        output.append("***\(node.nodeName)*** \r\n")
        if node.rightChild != nil {
            inOrder(node: node.rightChild!)
        }
        
    }
}
