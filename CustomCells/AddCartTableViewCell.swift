//
//  AddCartTableViewCell.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/21/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit

class AddCartTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var itembuyingimg: UIImageView!
    
  
    @IBOutlet weak var itembuyingname: UILabel!
    
    @IBOutlet weak var itembuyingprice: UILabel!
    
    @IBOutlet weak var itembuyingquantity: UILabel!
    
    @IBOutlet weak var multipledbuyingprice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
