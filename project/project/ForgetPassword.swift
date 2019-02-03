//
//  ForgetPassword.swift
//  project
//
//  Created by MAC on 22/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ForgetPassword: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var ConformPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.username.delegate=self
        self.passWord.delegate=self
        self.ConformPassword.delegate=self

       
    }
    

  
    @IBAction func resetPassword(_ sender: Any) {
        
        performSegue(withIdentifier: "LoginBack", sender: self)
    }
    
}
extension ForgetPassword:UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

