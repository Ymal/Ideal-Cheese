//
//  Firbasefunctions.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/21/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase




public func getitemimage(name: String ) -> UIImage {
    var itemimage = UIImage()
    let storage =  Storage.storage()
    let image = storage.reference().child("\(name)1.jpg")
    
    image.getData(maxSize: 600 * 600 * 1024) { data, error in
        if let error = error {
            print ("Uh-oh, an error occurred!", "\(error)")
        } else {
            // Data for "images/island.jpg" is returned
       let pic  = UIImage(data:data!)!
          print(pic)
       
    }
   
            }
 return itemimage
    
    
}
