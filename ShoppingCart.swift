//
//  ShoppingCart.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/16/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit



class ShoppingCart: NSObject {
    
    
    public var wholecart = [cartitem]()
    var  shipping : [String :Double] = ["" : 0.0]
    
    init(wholecart: [cartitem] , shipping : [String:Double] ){
       
       self.wholecart = wholecart
        self.shipping = shipping
    }

    
    func itemsum() -> Double {
        
        var zero = 0.0
        for i  in  0 ... wholecart.count {
            
            zero =  wholecart[i].price + zero
            
        }
        
        return zero
        
    }
    
    func totalweight() -> Double {
        
        var weight = 0.0
        
        for i in 0 ... wholecart.count {
            
          weight  = wholecart[i].quantity + weight
            
        }
        
        return weight
    }
    
    
    
    
}
