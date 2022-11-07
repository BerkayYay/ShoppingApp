//
//  ProductCollectionViewCell.swift
//  Shopping App
//
//  Created by Berkay YAY on 1.11.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productRate: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
