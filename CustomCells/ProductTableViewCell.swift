//
//  ProductTableViewCell.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/6/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var region: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var itemimage: UIImageView!
    
    
    
    @IBOutlet weak var s1: UIImageView!
    @IBOutlet weak var s2: UIImageView!
    @IBOutlet weak var s3: UIImageView!
    @IBOutlet weak var s4: UIImageView!
    @IBOutlet weak var s5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
