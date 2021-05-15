//
//  ListCollectionViewCell.swift
//  List Ranker
//
//  Created by Daniel Rivera on 5/1/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit

protocol ListCollectionProtocal {
    
    func showData(idex: Int)
    func deleteData(idex: Int)
}

class ListCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var collectionLabel: UILabel!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    static let reuseIdentifier = "ListCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    var delegate: ListCollectionProtocal?
    var iPath: IndexPath?
    
    public func configure(with text: String){
        collectionLabel.text = text
        collectionLabel.textAlignment = .center
        collectionLabel.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "ListCollectionViewCell", bundle: nil)
    }
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        
        delegate?.showData(idex: (iPath?.row)!)
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        delegate?.deleteData(idex: (iPath?.row)!)
        
    }
    

}
