//
//  LaunchScreen.swift
//  project
//
//  Created by MAC on 23/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class LaunchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginController=storyboard?.instantiateViewController(withIdentifier: "ViewController")
        UIApplication.shared.keyWindow?.rootViewController = loginController
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
