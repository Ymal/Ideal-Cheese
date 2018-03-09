//
//  AddressPopViewController.swift
//  
//
//  Created by Mimivirus on 2/18/18.
//

import UIKit


var addressIndex = 0
class AddressPopViewController: UIViewController, UITextFieldDelegate {

    
    private   let states = ["AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE",
                                           "NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
    
    
    
    
    
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var address1: UITextField!
    
    @IBOutlet weak var address2: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var zip: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBAction func cancelAddress(_ sender: Any) {
        
        RemoveView()
    }
    
    @IBAction func saveAddress(_ sender: Any) {
        
        
        print(address1.text!)
        if onlyletter(aWord: firstname.text! ) && (firstname.text?.isEmpty == false) {useraddresses[addressIndex].firstName = firstname.text!}else{self.nameAlert()}
        if onlyletter(aWord: lastName.text!) && (lastName.text?.isEmpty == false) {useraddresses[addressIndex].lastName = lastName.text!}else{nameAlert()}
        if onlylettersAndNumber(aAddress: address1.text! + address2.text!) && (address1.text?.isEmpty == false) {useraddresses[addressIndex].firstAddress = address1.text!
                                                                            useraddresses[addressIndex].lastAddress = address2.text!
        }else{addressAlert()}
        
        if onlyletter(aWord: city.text!) && (city.text?.isEmpty == false) {useraddresses[addressIndex].city = city.text!}else{ cityAlert()}
        if onlyletter(aWord: state.text!) && (state.text!.count == 2)  && (validateStatevalue(aState: state.text!)){useraddresses[addressIndex].state = state.text!}else{stateAlert()}
        if onlyNumbers(aNumber: phonenumber.text!) && (phonenumber.text!.count == 10){useraddresses[addressIndex].phonenumber = Int(phonenumber.text!)}else{phonenumberAlert()}
        
    }
    
    
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    let phonenumberstring = String(useraddresses[addressIndex].phonenumber!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(addressIndex)
        firstname.text = useraddresses[addressIndex].firstName
        lastName.text = useraddresses[addressIndex].lastName
        address1.text = useraddresses[addressIndex].firstAddress
        address2.text = useraddresses[addressIndex].lastAddress
        city.text = useraddresses[addressIndex].city
        state.text = useraddresses[addressIndex].state
       
        phonenumber.text =  phonenumberstring
        
        
       self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        showAnimate()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 //   override func viewWillAppear(_ animated: Bool) {
    
  //  }
    

    func showAnimate(){
        
        self.view.transform =  CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
    }
    
    
    func RemoveView(){
        
        
        UIView.animate(withDuration: 0.25) {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }
        
        self.view.removeFromSuperview()
        
        //self.view.removeFromSuperview()
        
        
    }
    
    
    
    func onlyletter(aWord: String) -> Bool{
        
        let allowedwords = CharacterSet.letters
        let inspectedCharecterSet = CharacterSet(charactersIn: aWord)
        return allowedwords.isSuperset(of: inspectedCharecterSet)
        
    }
    
    
    func onlylettersAndNumber(aAddress: String) -> Bool{
        
        let allowedwords = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789 ")
        let inspectedCharecterSet = CharacterSet(charactersIn: aAddress)
        return allowedwords.isSuperset(of: inspectedCharecterSet)
        
    }
    
    func onlyNumbers(aNumber: String)-> Bool {
        
        let allowedwords = CharacterSet.decimalDigits
        let inspectedCharecterSet = CharacterSet(charactersIn: aNumber)
        return allowedwords.isSuperset(of: inspectedCharecterSet)
        
        
    }
    
    
    func addressAlert(){
        
        let addressalert = UIAlertController(title: "Your Address looks Fufu ", message: "Please only use letters A-Z and Numbers 0-9", preferredStyle: .alert)
        addressalert.addAction(UIAlertAction(title: "click", style: .default, handler: nil))
        self.present(addressalert, animated: true, completion: nil)
        
    }
    
   func  nameAlert(){
    let namealert = UIAlertController(title: "What Kind Of Name Do You Have ? ", message: "Please only use letters A-Z", preferredStyle: .alert)
    namealert.addAction(UIAlertAction(title: "click", style: .default, handler: nil))
    self.present(namealert, animated: true, completion: nil)
    
    
    }
    
    func cityAlert(){
        let cityalert = UIAlertController(title: "Wait What City you from ?", message: "Please only use letters A-Z", preferredStyle: .alert)
        cityalert.addAction(UIAlertAction(title: "click", style: .default, handler: nil))
        self.present(cityalert, animated: true, completion: nil)
        
    }
    
    
    func stateAlert(){
        let statealert = UIAlertController(title: "Wow the 51st state really ?", message: "Please only use real American States", preferredStyle: .alert)
        statealert.addAction(UIAlertAction(title: "click", style: .default, handler: nil))
        self.present(statealert, animated: true, completion: nil)
        
    }
    
    func phonenumberAlert(){
        let phonealert = UIAlertController(title: "Why is your number so special", message: "Please only real phone numbers ", preferredStyle: .alert)
        phonealert.addAction(UIAlertAction(title: "click", style: .default, handler: nil))
        self.present(phonealert, animated: true, completion: nil)
        
    }
    
    
    func validateStatevalue(aState: String) -> Bool {
        
        for i in 0...(self.states.count - 1) {
            
            
            if states[i].contains(aState.uppercased())  {
                
                return true
            }
            
            }
        return false
        
        
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
