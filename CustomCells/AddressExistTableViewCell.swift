//
//  AddressExistTableViewCell.swift
//  CheeseStore
//
//  Created by Mimivirus on 2/6/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit

class AddressExistTableViewCell: UITableViewCell {

    @IBOutlet weak var fName: UILabel!
    
    @IBOutlet weak var lName: UILabel!
    
    
    @IBOutlet weak var addressfull: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var state: UILabel!
    
    
    @IBOutlet weak var zip: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    weak var delegate : addressbuttonpressed?
    
    
    @IBOutlet weak var addressbutton: UIButton!
    
    
    func setaddress(fName: String,
                    lName:String,
                    addressfull:String,
                    city: String,
                    state: String,
                    zip: Int,
                    phoneNumber: Int){
        self.fName.text = fName
        self.lName.text = lName
        self.addressfull.text = addressfull
        self.city.text = city
        self.state.text = state
        self.zip.text = String(zip)
        
        
        let wholeNumber = String(phoneNumber)
        let areacodeindex = wholeNumber.index(wholeNumber.startIndex, offsetBy: 3)
        let arecodecode = wholeNumber.prefix(upTo: areacodeindex)
        let   sevenNumbers = wholeNumber.suffix(from: areacodeindex)
        let threeNumbersindex = sevenNumbers.index(sevenNumbers.startIndex, offsetBy: 3)
        let threeNumbers = sevenNumbers.prefix(upTo: threeNumbersindex)
        let fourNumbers = sevenNumbers.suffix(from: threeNumbersindex)
        
       // let   lastfournumbers = String(phoneNumber).distance(from: 6, to: 9)
        self.phoneNumber.text = "(\(arecodecode))-\(threeNumbers)-\(fourNumbers)"
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



protocol addressbuttonpressed : class{
    func ichooseyou ()
    
    
}
