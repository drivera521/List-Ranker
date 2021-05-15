//
//  SavedList.swift
//  List Ranker
//
//  Created by Daniel Rivera on 4/30/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SavedList: Object{
    
    @objc dynamic var listName: String = ""
    var listItems = List<String>()
    
}
