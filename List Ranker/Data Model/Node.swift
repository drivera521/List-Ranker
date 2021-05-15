//
//  Node.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/11/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import Foundation

class Node{
    
     let nodeName: String
     var leftChild: Node?
     var rightChild: Node?
     
     init(nameValue: String, leftChild: Node? = nil, rightChild: Node? = nil) {
         
         self.nodeName = nameValue
         self.leftChild = leftChild
         self.rightChild = rightChild
     }
    
}
