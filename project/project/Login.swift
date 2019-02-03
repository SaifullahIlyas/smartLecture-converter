//
//  Login.swift
//  project
//
//  Created by MAC on 22/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import FirebaseAuth

class Login: UIViewController {
    let alert = UIAlertController(title: "Invalid Credential", message: "Retry with Correct username and password", preferredStyle: UIAlertController.Style.alert)
    @IBOutlet weak var ActivtyIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var usetnameTF: UITextField!
    @IBOutlet weak var loginimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ActivtyIndicator.isHidden=true;
        self.passwordTf.isSecureTextEntry=true;
        self.usetnameTF.delegate=self
        self.passwordTf.delegate=self
        UserDefaults.standard.set(nil, forKey: "USERNAME")
        UserDefaults.standard.set(nil, forKey: "PASSWORD")
        if(UserDefaults.standard.string(forKey: "USERNAME") != nil && UserDefaults.standard.string(forKey: "PASSWORD") != nil)
        {
        let loginController=storyboard?.instantiateViewController(withIdentifier: "ViewController")
            UIApplication.shared.keyWindow?.rootViewController = loginController}
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {ACTION in
            
         self.usetnameTF.text=nil
           self.passwordTf.text=nil
           self.usetnameTF.endEditing(true)
            self.passwordTf.endEditing(true)
            
            
        }
        
        
        
        
        ))

    }
    
    

    @IBAction func mainAppScreen(_ sender: Any) {
        ActivtyIndicator.isHidden=false
        
        ActivtyIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if usetnameTF.text != "" && passwordTf.text != ""{
            let user=self.usetnameTF.text!
            let pass=self.passwordTf.text!
            Auth.auth().signIn(withEmail: user, password: pass){
                (user,error) in
                if error == nil && user != nil
                {
                    let uiviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "navbar")
                    UIApplication.shared.keyWindow?.rootViewController=uiviewcontroller
                    
                    UserDefaults.standard.set(self.usetnameTF.text, forKey: "USERNAME")
                    UserDefaults.standard.set(self.passwordTf.text, forKey: "PASSWORD")
                }
                else{
                    self.alert.message=error?.localizedDescription
                    self.present(self.alert,animated: true, completion: nil)
                }
            }
            
            
            
        }
        else{
            self.present(self.alert,animated: true, completion: nil)
        }
        ActivtyIndicator.stopAnimating()
    UIApplication.shared.endIgnoringInteractionEvents()
    }
   
   
    @IBAction func register(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
    

}
extension Login:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    

}
