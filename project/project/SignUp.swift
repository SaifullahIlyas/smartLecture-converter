//
//  SignUp.swift
//  project
//
//  Created by MAC on 22/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseStorage

class SignUp: UIViewController {
    var useridentifier=""
    var alert=UIAlertController(title: "Image required", message: "please first select the image ", preferredStyle: UIAlertController.Style.alert)
let imgpicker=UIImagePickerController()
    @IBOutlet weak var userImg: UIImageView!
    var chekForImg=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "Ok", style:UIAlertAction.Style.default, handler: nil))
     
        

        
    }
    

    @IBAction func loadImg(_ sender: Any) {
        imgpicker.delegate=self
        imgpicker.sourceType = .photoLibrary
        imgpicker.isEditing=true
    
        chekForImg=false
        self.present(imgpicker,animated: true,completion: nil)
        
    }
   
    @IBAction func uploadImg(_ sender: Any) {
        if(!chekForImg)
        {UpLoadImage()
            print("in  if condition")
            self.present(self.alert,animated: true,completion: nil)
           
            
                    }
        else{
            UpLoadImage()
            print("in else condiotion")
            performSegue(withIdentifier: "MainLogin", sender: self)
        }
        }
    func UpLoadImage(){

        
        let meteda=StorageMetadata()
        meteda.contentType="image/jpeg/png"

        let uiimage=userImg.image as! UIImage
      // data =  uiimage.jpegData(compressionQuality: 0.8)!
     let data =  uiimage.pngData()!
       let userref = StorageReference().child("/userimages/"+useridentifier)
       userref.putData(data, metadata: meteda)
        print("image is inserted in the fire storage")
            
            
        }
           
        
    }


extension SignUp: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            userImg.image = img
            chekForImg=true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
extension SignUp:UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
