//
//  ProductViewController.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/5/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseStorage

struct item  {
    
    let name  :  String!
    let origin : String!
    let price : Double!
    let description : String!
    let instock : Bool!
    let compliment : [String]!
    let cut : Bool!
    let searchwords : [String]!
    let expiration : String!
    let available : Bool!
    let rating : Double!
    
}


struct cartitem {
    
    let name : String!
    let price : Double!
    var  quantity: Double!
   
    
}
class ProductViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
     var items = [item]()
    var currentItems=[item]()
     var leftConstriants : NSLayoutConstraint!
    var searchBar :UISearchBar = UISearchBar()
    
    
    
    @IBOutlet weak var htable: UITableView!
    
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.currentItems.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell =  htable.dequeueReusableCell(withIdentifier: "HCell", for: indexPath as IndexPath) as! ProductTableViewCell
        let storage =  Storage.storage()
        let image = storage.reference().child("\(self.currentItems[indexPath.row].name!)1.jpg")
        
        cell.itemimage.image = nil
      
     
                image.getData(maxSize: 1 * 300 * 300) { data, error in
                    if let error = error {
                        print ("Uh-oh, an error occurred!", "\(error)")
                    } else {
                        // Data for "images/island.jpg" is returned
                        cell.itemimage.image  = UIImage(data:data!)
                    }
                }
        
        
        cell.name.text = self.currentItems[indexPath.row].name
        cell.region.text = self.currentItems[indexPath.row].origin
        cell.price.text = "\(self.currentItems[indexPath.row].price!)0"
        cell.s1.image =     UIImage(named: "star")
        cell.s2.image =     UIImage(named: "star")
        cell.s3.image =     UIImage(named: "star")
        cell.s4.image =     UIImage(named: "star")
        cell.s5.image =     UIImage(named: "star")
        cell.s5.tintColor = UIColor.yellow
        
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SingleProduct", sender: currentItems[indexPath.row])
    
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       
        let transition = segue.destination as! SingleProductViewController
        
         transition.singleitem = sender as! item
    
    

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
    }
    
    
    func posttodb(){
        var  ref: DatabaseReference?
        ref = Database.database().reference()
        
        let name  = "Brie"
        let origin = "France_Brie"
        let price : Double = 13.00
        let description = "Famous soft ripened buttery cheese from france "
        let instock = true
        let compliment : [String] = ["Fig Jam", "Comte", "Manchego"]
        let cut = true
        let searchwords : [String] = ["buttery","soft","France","pasturized","Cow"]
        let expiration : String = "3 weeks"
        let available : Bool = true
        let rating : Double = 5/5
        
        
        //let joeSmith : [String : AnyObject] = [
        //"Name" : "Joe Smith" as AnyObject,
        // "Height" : 42 as AnyObject,
        // "Soccer Expo" : true as AnyObject,
        // "Guardian" : "Jim and Jan Smith" as AnyObject]
        
        
        
        let item : [String : Any] = [ "name" : name,
                                      "origin": origin,
                                      "price"  : price,
                                      "description": description,
                                      "instock" :instock,
                                      "compliment" : compliment,
                                      "cut" : cut,
                                      "searchwords" : searchwords,
                                      "expiration" :expiration,
                                      "available" : available,
                                        "rating": rating]
        
        ref?.child("Item").childByAutoId().setValue(item)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ideal Cheese"

       
        htable.delegate = self
        htable.dataSource = self
        searchBar.delegate  = self
        assert(navigationController != nil, "this view controller must be embedded in a navigation controller" )
        
    
        self.htable.contentInsetAdjustmentBehavior = .never
        
        Expandview()
        
        var  ref: DatabaseReference?
        ref = Database.database().reference()
        ref?.child("Item").queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
            
            if snapshot.exists(){
                
                let name  = snapshot.childSnapshot(forPath: "name").value as? String
                let origin = snapshot.childSnapshot(forPath: "origin").value as? String
                let price = snapshot.childSnapshot(forPath: "price").value as? Double
                let description = snapshot.childSnapshot(forPath: "description").value as? String
                let instock = snapshot.childSnapshot(forPath: "instock").value as? Bool
                let compliment = snapshot.childSnapshot(forPath: "compliment").value as? [String]
                let cut = snapshot.childSnapshot(forPath: "cut").value as? Bool
                let searchwords = snapshot.childSnapshot(forPath: "searchwords").value  as? [String]
                let expiration = snapshot.childSnapshot(forPath: "expiration").value  as? String
               let available = snapshot.childSnapshot(forPath: "available").value  as? Bool
                let rating = snapshot.childSnapshot(forPath: "rating").value  as? Double
                
                self.items.insert(item( name: name,
                                       origin : origin,
                                       price : price,
                                       description : description,
                                       instock :instock,
                                       compliment : compliment,
                                       cut : cut,
                                       searchwords:searchwords,
                                       expiration:expiration,
                                       available:available,
                                       rating:rating
                                       
                                       
                ), at:0 )
                
               
                print(snapshot)
                print (self.items)
                print (self.items[0].name)
                print(self.items.count)
                print(self.searchBar.text!)
                
                
         self.currentItems = self.items.sorted(by: {$0.name < $1.name})
                self.htable.reloadData()
            }
  
        })
        
        
  
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // async when changing tableview
    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String){
        
        guard !searchText.isEmpty == true else{
            
          
          self.currentItems = self.items.sorted(by: {$0.name < $1.name})
            self.htable.reloadData()
            
            return
        }
        // searchtext need to be lowercase tooo
        
    
        
        self.currentItems = self.items.filter{$0.name.lowercased().contains(searchText.lowercased())}
            
        for anitem in self.items{
            
            for aword in   anitem.searchwords{
                
                if aword.lowercased().contains(searchText.lowercased()){
                    //self.currentItems.removeAll()
                    self.currentItems.append(anitem)
                    self.currentItems = self.currentItems.sorted(by: {$0.name < $1.name})
                    self.htable.reloadData()
                    
                }
                
            }
            
            
        }
        
            
            /*($0.searchwords.first?.lowercased().contains(searchText.lowercased()))! */
        
        self.htable.reloadData()
        
      /*  DispatchQueue.global(qos: .userInteractive).async {
            guard !searchText.isEmpty == true else{
                
                self.currentItems = self.items
                DispatchQueue.main.async {
                    self.htable.reloadData()
                }
                return
            }
        }
        
         self.currentItems = self.items.filter{$0.name.lowercased().contains(searchText.lowercased())}
        
        DispatchQueue.main.async {
            self.htable.reloadData()
      
         
         } */
    }
        
        

 var expandview = Exapandableheader()
    
    func Expandview() {
        
        navigationItem.titleView = expandview
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(ProductViewController.toggle))
        navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: nil)
        
        let idealcheese = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 80))
        idealcheese.text = "Ideal Cheese"
        
        
     
        
        //idealcheese.center = CGPoint(x: self.searchBar.frame.size.width/2, y: self.searchBar.frame.size.height/2)
        idealcheese.center = CGPoint(x: (expandview.frame.size.width * 4.0), y: (expandview.frame.size.height/2.0))
        
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        expandview.addSubview(self.searchBar)
      
        self.leftConstriants = self.searchBar.leftAnchor.constraint(equalTo: expandview.leftAnchor)
        self.leftConstriants.isActive = false
        
        self.searchBar.rightAnchor.constraint(equalTo: expandview.rightAnchor).isActive = true
        self.searchBar.bottomAnchor.constraint(equalTo: expandview.bottomAnchor).isActive = true
        self.searchBar.topAnchor.constraint(equalTo: expandview.topAnchor).isActive = true
        
    
        
        
        
    }
    
   
    
    @objc func toggle(){
        print(searchBar.text!)
        print(self.items)
        
        
       //let label = UILabel(frame: CGRect(x:0, y: 0, width: 250, height: 50))
        
        let isOpen = self.leftConstriants.isActive == true
        
       
  
         self.leftConstriants.isActive = isOpen ? false : true
        
        UIView.animate(withDuration: 1, animations: {
            
            self.navigationItem.titleView?.alpha = isOpen ? 0:1
           
            self.navigationItem.titleView?.layoutIfNeeded()
            
            
        })
 /*  if  isOpen == false {
            
            label.textAlignment = .center
            label.text = "Ideal Cheese"
            label.alpha = 0
            expandview.addSubview(label)
            
            
        
        }else{
            label.textAlignment = .center
            label.text = "Ideal Cheese"
            label.alpha = 1
            expandview.addSubview(label)
              }
       
        
      */            }


}
