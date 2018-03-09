//
//  PopUpViewController.swift
//  CheeseStore
//
//  Created by Mimivirus on 1/28/18.
//  Copyright © 2018 IdealCheese. All rights reserved.
//

import UIKit


 var rowtoEdit = 0
var poundsselectedforEditing = 0.0
class PopUpViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    
    func    pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        poundsselectedforEditing =  quantityarray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return quantityarray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(quantityarray[row])
    }
    
    
    
    @IBAction func cancelEdit(_ sender: Any) {
        
        RemoveView()
    }
    
    
    @IBAction func changetheQuantity(_ sender: Any) {
        if poundsselectedforEditing == 0.0 {
            
            
            awholecart.remove(at: rowtoEdit)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            RemoveView()
            
        }
        else{
        awholecart[rowtoEdit].quantity = poundsselectedforEditing
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        RemoveView()
        }
    }
    
    @IBOutlet weak var editquantityPicker: UIPickerView!
    
    
    @IBOutlet weak var Edit: UIBarButtonItem!
    
    @IBOutlet weak var theeditToolBar: UIToolbar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
editquantityPicker.dataSource = self
        editquantityPicker.delegate = self
        
        showAnimate()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate(){
        
        self.view.transform =  CGAffineTransform(scaleX: 1.3, y: 1.3)
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


