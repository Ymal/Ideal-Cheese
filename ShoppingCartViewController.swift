//
//  ShoppingCartViewController.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/21/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

struct address {
   
    var firstName : String?
    var  lastName : String?
    var firstAddress : String?
    var lastAddress : String?
    var state : String?
    var city : String?
    var zipcode : Int?
    var phonenumber:Int?
    var chosenaddress: Bool?

}


struct shipping {
    

let  shippingOption : String?
let  price :  Double?
  
    
    
}

struct payment{
    let paymentName : String?
    let creditnumber : Int?
    let month : Int?
    let year : Int?
    let cvv : Int?
    let isExpanded: Bool?
}

var quantityarray = [Double]()
var awholecart = [cartitem]()
var cartindexpath = Int()
var editpicker = UIPickerView()


var useraddresses = [address]()
var shippingOptions = [shipping]()
var paymentOptions = ["Paypal","Credit","Applepay" ]

class ShoppingCartViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITabBarDelegate{
    

    
   
    
    
    
  var   isExpanded1 = false
  var   isExpanded2 = false
  var   isExpanded3 = false
    
    
    
    @IBOutlet weak var quantitytextfield: UITextField!
    

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        switch section {
        case 0 : return "Items in Cart"
        case 1 : return  "Address"
        case 2 : return "Shipping"
        case 3 : return  "Payment Options"
        case 4  : return  "Checkout"
            
        default:
            return ""
        }
        
        
        }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let dropButton = UIButton(type: .system)
        dropButton.backgroundColor = UIColor.red
        dropButton.setTitleColor(.white, for: .normal)
        dropButton.setTitleShadowColor(.black, for: .normal)
        dropButton.layer.borderWidth = 0.25
        dropButton.layer.borderColor = UIColor.black.cgColor
        dropButton.titleLabel?.font = UIFont(name: "System", size: 27)
        
        dropButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        dropButton.tag = section
        
        switch section {
            
        case 0  : dropButton.setTitle("Cart", for: .normal); return dropButton
        case 1  : dropButton.setTitle("Address", for: .normal) ; return dropButton
        case 2  : dropButton.setTitle("Shipping", for: .normal) ; return dropButton
        case 3  : dropButton.setTitle("Payment Options", for: .normal); return dropButton
        case 4  : dropButton.setTitle("Review Order", for: .normal) ; return dropButton
            
            
        default:
            return dropButton
        }
        
        
    
    }
    
    
    @objc func handleExpandClose(dropButton : UIButton){
        switch dropButton.tag {
            
        case 1 : addresspop()
        case 2 : shippingpop()
        case 3 : paymentpop()
            
           
        
        
        
            
        default:
            return
        }
        
        
        
        
    }
    
   /* internal func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
   
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = UIColor.red
        header.textLabel?.font = UIFont(name: "Times", size: 16)
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = UIColor.white
       
        
    
   
        
        
        
        //let header = UIFont(name: "Times", size: 16)
    
    
    
    }
        
   */
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 : return awholecart.count
            
            
        case 1 : if self.isExpanded1 == false {return 0} else{ return useraddresses.count}
        case 2 : if self.isExpanded2 == false {return 0} else{ return shippingOptions.count}
        case 3 : if self.isExpanded3 == false {return 0} else {return paymentOptions.count}
        case 4 : return 1
  
        default:    return 0
            
        }
        
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let normalcell = UITableViewCell()
        
        switch indexPath.section{
        
        case 0 : let cell = self.carttable.dequeueReusableCell(withIdentifier: "cart") as! AddCartTableViewCell
        cell.itembuyingname.text = awholecart[indexPath.row].name
        cell.itembuyingprice.text = String(awholecart[indexPath.row].price)
        cell.itembuyingquantity.text = String(awholecart[indexPath.row].quantity)
       // DispatchQueue.main.async { cell.itembuyingimg.image = getitemimage(name: awholecart[indexPath.row].name!) }
    
  
        let storage =  Storage.storage()
        let image = storage.reference().child("\(awholecart[indexPath.row].name!)1.jpg")
        
        image.getData(maxSize: 600 * 600 * 1024) { data, error in
            if let error = error {
                print ("Uh-oh, an error occurred!", "\(error)")
            } else {
                // Data for "images/island.jpg" is returned
          cell.itembuyingimg.image = UIImage(data:data!)!
              
            }
        }
 
     
        cell.multipledbuyingprice.text = String( awholecart[indexPath.row].price * awholecart[indexPath.row].quantity )
       
        return cell
            
        case 1 : return setadddresscell(aindeaxpathrow: indexPath)
        case 2 : return normalcell
        case 3 : return normalcell
        case 4 : return normalcell
        default :
            return normalcell
        }
    }
    
    
    func setadddresscell  (aindeaxpathrow : IndexPath) -> UITableViewCell{
    
    let cell = self.carttable.dequeueReusableCell(withIdentifier: "addressExist") as! AddressExistTableViewCell
   cell.setaddress(fName: useraddresses[aindeaxpathrow.row].firstName!,
                   lName: useraddresses[aindeaxpathrow.row].lastName!,
                        addressfull: ( useraddresses[aindeaxpathrow.row].firstAddress! + useraddresses[aindeaxpathrow.row].lastAddress!),
                        city: useraddresses[aindeaxpathrow.row].city!,
                        state: useraddresses[aindeaxpathrow.row].state!,
                        zip: useraddresses[aindeaxpathrow.row].zipcode!,
                        phoneNumber: useraddresses[aindeaxpathrow.row].phonenumber!)
        
        
        cell.addressbutton.tag = aindeaxpathrow.row
       
        
        if useraddresses[aindeaxpathrow.row].chosenaddress == true {
           cell.addressbutton.setImage(#imageLiteral(resourceName: "cheeseon"), for: .normal)
            
            
        }else{
            
             cell.addressbutton.setImage(#imageLiteral(resourceName: "cheeseoff"), for: .normal)
        }
        cell.addressbutton.addTarget(self, action: #selector(addressslected), for: .touchUpInside)
    
  
    return cell
    
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
     
        let editaction = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
        
            switch indexPath.section{
                
            case 0:  self.editIteminCart(cartindexpath: indexPath)
            //case 1:  self.editAddressinCart(cartindexPath: indexPath)
            default:
                _ = 0
            }
        
        }

       
     
     
     editaction.backgroundColor = UIColor.darkGray
     
     let deleteaction = UITableViewRowAction(style: .destructive, title: "Remove") { (action, index) in
     awholecart.remove(at: indexPath.row)
     self.carttable.deleteRows(at:[indexPath], with: .fade)
        }
        deleteaction.backgroundColor = UIColor.red
     return [deleteaction, editaction]
     }
    
    
    
    func editIteminCart(cartindexpath: IndexPath){
        
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
        self.addChildViewController(popOverVc)
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
        print(cartindexpath)
      rowtoEdit = cartindexpath.row
        
        
    }
    
  /*  func editAddressinCart(cartindexPath:IndexPath){
        let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addresspopup") as! AddressPopViewController
        self.addChildViewController(popOverVc)
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParentViewController: self)
        addressIndex = cartindexPath.row
    }
     */
    @IBOutlet weak var carttable: UITableView!
    
    
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let  section = indexPath.section
        
        switch section {
        case 0 : return 130
        case 1 : return 100
        case 4 : return 400
            
            
        default:
            return 100
        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.carttable.rowHeight = 130
        
     self.carttable.reloadData()
        carttable.dataSource = self
        carttable.delegate = self
        
       addlbs()
        
        let myaddress = address(firstName: "Ymal", lastName: "bracca", firstAddress: "434 zona norte", lastAddress: "", state: "NY", city: "Pandemonium", zipcode: 10027, phonenumber: 6467503430, chosenaddress: false)
        let myaddress2 = address(firstName: "dfsdf", lastName: "bdsfliaeb", firstAddress: "jdbcniwjbf", lastAddress: "ejknfwfn", state: "kdno", city: "jbgflasidj", zipcode: 123124, phonenumber: 123124213, chosenaddress: false )
        let shipping1 = shipping(shippingOption: "UPS Ground", price: 20.00)
        let shipping2 = shipping(shippingOption: "Postmates", price: 30.00)
        let shipping3 = shipping(shippingOption: "Pick Up", price: 0.0)
        
        useraddresses.append(myaddress)
        useraddresses.append(myaddress2)
        shippingOptions.append(shipping1)
        shippingOptions.append(shipping2)
        shippingOptions.append(shipping3)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateedittableview), name: NSNotification.Name(rawValue: "load"), object: nil)
     
        
           NotificationCenter.default.addObserver(self, selector: #selector(removeitem), name: NSNotification.Name(rawValue: "removeitem"), object: nil)
        
        
        self.carttable.contentInsetAdjustmentBehavior = .never
        
       
        
        
        //var  mycart = ShoppingCart(wholecart: awholecart, shipping: shipping )
       
        print(awholecart)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// reloads the table view after editing the the cart from a different view
    override func viewDidAppear(_ animated: Bool) {
        self.carttable.reloadData()
    }
    
    
    
    func addlbs() {
        
        for index in 0...200  {
            
            let   t = 0.5
            
            let   sum = t * Double(index)
           quantityarray.append(sum)
        quantityarray = quantityarray.sorted(by: {$0 < $1 })
        }
        
        
        
        
}
    @objc func addressslected(button:UIButton){

        
        print("wtf")
        print (button.tag)
        for i in 0...useraddresses.count-1{
            
            if button.tag == i {
                
                
                useraddresses[i].chosenaddress! = true
             
            }else if  (button.tag != i && useraddresses[i].chosenaddress == true){
                
                useraddresses[i].chosenaddress! = false
            }
          
        }
        
       
self.carttable.reloadData()
        
            
            
        }
        

        
    
    
    
    
    @objc func updateedittableview(notification: NSNotification){
        
        self.carttable.reloadData()
        
    }
    
    
    @objc func removeitem(notification: NSNotification, givemerow : Int){
  
        self.carttable.reloadData()    }
    
    
    
    func addresspop(){
        
        if self.isExpanded1 == false { self.isExpanded1 = true} else { self.isExpanded1 = false}
        
        var addressesIndexPath = [IndexPath]()
        
        for i in 0 ... useraddresses.count-1 {
            let indexpath = NSIndexPath(row: i, section: 1)
            
            addressesIndexPath.append(indexpath as IndexPath)
            
            print(addressesIndexPath)
        }
        if self.isExpanded1 == false {
            
            carttable.deleteRows(at: addressesIndexPath, with: .fade)
            
        }else{
            
            carttable.insertRows(at: addressesIndexPath, with: .fade  )
        }
        
        
}
    
    
    func shippingpop(){
        
        if self.isExpanded2 == false { self.isExpanded2 = true} else { self.isExpanded2 = false}
        
        var shippingIndexPath = [IndexPath]()
        
        for i in 0 ...  (shippingOptions.count - 1) {
           let indexpath = NSIndexPath(row: i, section: 2)
            
           shippingIndexPath.append(indexpath as IndexPath)
            print(shippingIndexPath)
    }
        if self.isExpanded2 == false {
            
            carttable.deleteRows(at: shippingIndexPath, with: .fade)
            
        }else{
            
            carttable.insertRows(at: shippingIndexPath, with: .fade  )
        }
        
        
        
        
        
        
    }
    
    
    func paymentpop(){
        
        if self.isExpanded3 == false { self.isExpanded3 = true} else { self.isExpanded3 = false}
        
        var paymentIndexPath = [IndexPath]()
        
        for i in 0 ...  (paymentOptions.count - 1) {
            let indexpath = NSIndexPath(row: i, section: 3)
            
            paymentIndexPath.append(indexpath as IndexPath)
            print(paymentIndexPath)
        }
        if self.isExpanded3 == false {
            
            carttable.deleteRows(at: paymentIndexPath, with: .fade)
            
        }else{
            
            carttable.insertRows(at: paymentIndexPath, with: .fade  )
        }
        
        
        
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
