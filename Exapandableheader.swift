//
//  Exapandableheader.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/7/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit

class Exapandableheader: UIView {

    
    override init(frame: CGRect) {
        super.init (frame:frame)
        backgroundColor = UIColor.clear
   
        translatesAutoresizingMaskIntoConstraints  = false
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override  var intrinsicContentSize: CGSize{
        
        return UILayoutFittingExpandedSize
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
