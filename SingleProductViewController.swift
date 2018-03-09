//
//  SingleProductViewController.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/10/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseStorage

class SingleProductViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
    
    private var lbs = [Double]()
    private var setamount : Double = 0.0
    
   private var pickervalue :Double = 0.0
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lbs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.setamount = self.lbs[row]
        
    return String(self.setamount)
        
    }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      pickervalue = self.lbs[row]
   }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let complimentcell = singleproduct.dequeueReusableCell(withReuseIdentifier: "compliment", for: indexPath) as! SingleProductCollectionViewCell
        complimentcell.backgroundColor = UIColor.red
        return complimentcell
    }
    
   
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gallery: UIImageView!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var singleproduct: UICollectionView!
    
   
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var Star1: UIImageView!
    @IBOutlet weak var Star2: UIImageView!
    @IBOutlet weak var Star3: UIImageView!
    @IBOutlet weak var Star4: UIImageView!
    @IBOutlet weak var Star5: UIImageView!
    @IBOutlet weak var flag: UIImageView!
   
   @IBOutlet weak var cow: UIImageView!
   @IBOutlet weak var goat: UIImageView!
   @IBOutlet weak var sheep: UIImageView!
   @IBOutlet weak var pig: UIImageView!
   @IBOutlet weak var duck: UIImageView!
   
   @IBOutlet weak var chicken: UIImageView!
   @IBOutlet weak var fish: UIImageView!
   @IBOutlet weak var quantity: UIPickerView!
   @IBOutlet weak var nut: UIImageView!
   @IBOutlet weak var beer: UIImageView!
    @IBOutlet weak var raw: UIImageView!
    
    
    
   var singleitem = item(name: nil, origin: nil, price: nil, description: nil, instock: nil, compliment: nil, cut: nil, searchwords: nil, expiration: nil, available: nil, rating:nil)
   
   //private var images : [(cheesephoto: UIImage, cheesenumber: Int)] = []
   private var images : [Int: UIImage] = [:]
   
   
   func setRating(){
         self.Star1.image = UIImage(named: "star")
         self.Star2.image = UIImage(named: "star")
         self.Star3.image = UIImage(named: "star")
         self.Star4.image = UIImage(named: "star")
         self.Star5.image = UIImage(named: "star")
     
      
    
      self.cow.image = UIImage(named:"cow-head")
      self.goat.image = UIImage(named: "goat-head")
      self.sheep.image = UIImage(named: "female-sheep-head")
      self.pig.image = UIImage(named: "pig-head")
      self.chicken.image = UIImage(named: "rooster")
      self.duck.image = UIImage(named: "duck-head")
      self.fish.image = UIImage(named: "big-piranha")
      self.nut.image = UIImage(named: "peanuts")
    self.beer.image = UIImage(named: "beer")
    self.raw.image = UIImage(named: "raw")
      self.beer.tintColor = UIColor.black
      
      for searchword in singleitem.searchwords{
         switch searchword{
         case "Cow" : self.cow.tintColor = UIColor.red
         case "Goat" : self.goat.tintColor = UIColor.red
         case "Sheep" : self.sheep.tintColor = UIColor.red
         case "Pig" : self.pig.tintColor = UIColor.red
         case "Chicken" : self.chicken.tintColor = UIColor.red
         case "Duck" : self.duck.tintColor = UIColor.red
         case "Fish" : self.fish.tintColor = UIColor.red
          case "Nut" : self.nut.tintColor = UIColor.red
          case "Alchol" : self.beer.tintColor = UIColor.red
          case "Raw" : self.raw.tintColor = UIColor.red
            
         default: self.cow.tintColor = UIColor.black
         }
         
      }
      
      
    
      
    }
    
    
    func setflag(){
      
        var country = self.singleitem.origin.components(separatedBy: "_")
        switch country[0] {
        
            
           case  "France" : self.flag.image = UIImage(named: "france")
           case  "Germany" : self.flag.image = UIImage(named: "germany")
           case "Netherlands" : self.flag.image = UIImage(named: "netherlands")
           case   "Ireland" : self.flag.image = UIImage(named: "ireland")
           case  "Italy" : self.flag.image = UIImage(named: "italy")
           case  "Spain" : self.flag.image = UIImage(named: "spain")
         case  "United-Kingdom" : self.flag.image = UIImage(named: "united-kingdom")
         case  "United States" : self.flag.image = UIImage(named: "united-states")
         case  "Portugal" : self.flag.image = UIImage(named: "portugal")
            case  "Norway" : self.flag.image = UIImage(named: "norway")
            case  "Denmark" : self.flag.image = UIImage(named: "denmark")
            
            
        default: country[0] = ""
        
    }
    }
    
    
   override func viewDidLoad() {
      super.viewDidLoad()
        
        
        self.singleproduct.delegate = self
        self.singleproduct.dataSource = self
        self.quantity.delegate = self
        self.quantity.dataSource = self
    
    
        
        self.name.text = singleitem.name
        self.about.text = singleitem.description
        self.price.text = "$\(String(singleitem.price)) LB"
    
      setRating()
       addlbs()
    
    setflag()
    
 
     
      
      
      var imagename = [String]()
      
      for i in 0 ... 4{
         let t = i+1
         let url = "\(self.singleitem.name!)\(String(t)).jpg"
         imagename.append(url)
      }
      
      let sortedurl = imagename.sorted(by: {$0 < $1})
      let storage =  Storage.storage()
      
      
      for i in 0...4{
         
         let image = storage.reference().child(sortedurl[i])
       
         image.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
               print ("Uh-oh, an error occurred!", "\(error)")
            } else {
               // Data for "images/island.jpg" is returned
               if let data = data {
                  let aimage = UIImage(data:data)
                 
                  self.images[i] = aimage!
                 
                 
                  let  sorteddictionary = self.images.sorted(by: {$0.key < $1.key})
                  let imagearray = Array(sorteddictionary.map({$0.1}))
                  
                  
                  self.gallery.layer.borderWidth = 0.75
                  self.gallery.layer.borderColor = UIColor.black.cgColor
                  self.gallery.layer.shadowRadius = 6
                  self.gallery.layer.shadowOpacity = 0.4
                  self.gallery.layer.shadowColor = UIColor.black.cgColor
                  self.gallery.animationImages = imagearray
                  
                  self.gallery.animationDuration = 10.0
                  self.gallery.startAnimating()
               }
               
               
            }
            
         }

         
         
         
         
         
      }
      
     
      
      
   }
    

         
      
   @IBAction func addtocart(_ sender: Any) {
       if  self.pickervalue == 0.0 {
         
      let alert = UIAlertController(title: "Whats wrong with you ", message: "Please select a quantity", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "click", style: .default, handler: nil))
       self.present(alert, animated: true, completion: nil)
         
      }else{
         if awholecart.isEmpty == true {
            
            let  newitem = cartitem(name: self.singleitem.name, price: self.singleitem.price, quantity: self.pickervalue )
            
            awholecart.append(newitem)
         }else{
         for i in 0 ... (awholecart.count - 1) {
            
            if awholecart[i].name == self.singleitem.name {
               
               awholecart[i].quantity = awholecart[i].quantity + self.pickervalue
               
               print(awholecart[i].name)
               print(self.singleitem.name )
               print(awholecart.count)
               return
            }
               
            
            }
            let  newitem = cartitem(name: self.singleitem.name, price: self.singleitem.price, quantity: self.pickervalue )
            
            awholecart.append(newitem)
            
                  }
         }
         }
      
    
     
   
   
   
   
   
 

    
    func addlbs() {
        
        for index in 0...200  {
            
          let   t = 0.5
           
          let   sum = t * Double(index)
            self.lbs.append(sum)
                 self.lbs = self.lbs.sorted(by: {$0 < $1 })
        }
       
        
        
    }
    
    
      
   
     
 
   

        // Do any additional setup after loading the view.
            

 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

        
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
