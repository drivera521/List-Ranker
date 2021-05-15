//
//  OptionsViewController.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/11/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    @IBOutlet weak var createListImageView: UIImageView!
    @IBOutlet weak var rankedListImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        let imageTapCreate = UITapGestureRecognizer(target: self, action: #selector(imageTapped))

        let imageTapRanked = UITapGestureRecognizer(target: self, action: #selector(imageTapped2))
        createListImageView.isUserInteractionEnabled = true
        rankedListImageView.isUserInteractionEnabled = true
        
        createListImageView.addGestureRecognizer(imageTapCreate)
        rankedListImageView.addGestureRecognizer(imageTapRanked)

         
         }
         
    @objc func imageTapped() {
        
        performSegue(withIdentifier: "gotoNewList", sender: self)
             

    }
    
    @objc func imageTapped2() {
        
        performSegue(withIdentifier: "gotoListCollection", sender: self)
    }

}
