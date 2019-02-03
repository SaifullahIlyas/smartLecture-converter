//
//  Register.swift
//  project
//
//  Created by MAC on 29/12/2018.
//  Copyright © 2018 MAC. All rights reserved.

//

import UIKit
import FirebaseAuth


class Register: UIViewController{
    var alert=UIAlertController(title: "", message: "", preferredStyle: .alert)
    var alerttitle=""
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var conformPass: UITextField!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        Password.delegate=self
        Email.delegate=self
        conformPass.delegate=self
        
      RegisterBtn.layer.cornerRadius=30
        RegisterBtn.layer.shadowRadius=30
    }
    

    @IBAction func Register(_ sender: Any) {
        alert=UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if(Email.text=="" || Password.text=="" || conformPass.text==""){
            createAlert(alerttitle: "Input Empty", alertMessage: "All the inputs are required")
            self.present(alert,animated: true,completion: nil)
        }
       if(Password.text != conformPass.text)
        {
           createAlert(alerttitle: "Password Unmatched", alertMessage: "Password Should be matched")
            self.present(alert,animated: true,completion: nil)
        }
        if(Email.text != "" && Password.text != "" && conformPass.text != ""){
            let user=self.Email.text!
            let pass = self.Password.text!
            Auth.auth().createUser(withEmail: user, password: pass){ (user, error) in
                if( error != nil)
                {
                    self.createAlert(alerttitle: "Registratio error", alertMessage:(error?.localizedDescription)!)
                }
                else{
                print("succesfull")
                self.performSegue(withIdentifier: "userimg", sender: self)
                }
            }
        
    
        
    }
    }
    func createAlert(alerttitle:String,alertMessage:String) {
        alert.title=""
        alert.message=""
        alert.title=alerttitle
        alert.message=alertMessage
        alert.addAction(UIAlertAction(title: "Retry", style:.default, handler:{ACTION in
           self.alert.dismiss(animated: true, completion:nil)
        
           
        
        }))
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinatioController=storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
        destinatioController.useridentifier=self.Email.text!
    }

}
extension Register:UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
