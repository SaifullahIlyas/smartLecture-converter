//
//  ViewController.swift
//  project
//
//  Created by MAC on 21/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import TesseractOCR
import SwiftGoogleTranslate


class ViewController: UIViewController {
     let ImagePicker = UIImagePickerController()
   
    @IBOutlet weak var actityIn: UIActivityIndicatorView!
    var data=""
    var outputurdu=""
    let jasonencoder=JSONEncoder()
    
    @IBOutlet weak var proceesButton: UIButton!
    @IBOutlet weak var imagePic: UIImageView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
         ImagePicker.delegate = self;
        actityIn.isHidden=true;
        ImagePicker.allowsEditing=true
       
    }

    @IBAction func SelectCamera(_ sender: Any) {
        ImagePicker.sourceType = .camera
        
        self.present(ImagePicker,animated: true,completion: nil)
        imagePic.layer.zPosition=0
        proceesButton.layer.zPosition = 1.0
    }
    @IBAction func menuButton(_ sender: Any) {
    }
    @IBAction func gallerryImage(_ sender: Any) {
        
       ImagePicker.sourceType = .photoLibrary
        
        self.present(ImagePicker,animated: true,completion: nil)
        imagePic.layer.zPosition=0
        proceesButton.layer.zPosition = 1.0
    }
    
    
    @IBAction func convertIMage(_ sender: Any) {
        
        
       startActivityIndicator()
            if let tesserAct = G8Tesseract(language: "eng"){
                
                tesserAct.engineMode = .tesseractCubeCombined
                tesserAct.pageSegmentationMode = .auto
                tesserAct.image = self.imagePic.image!
                
                tesserAct.recognize()
                if  let resultText = tesserAct.recognizedText{
                    print(resultText)
                    data = tesserAct.recognizedText!
                }
                else
                {
                    print("nothing")
                    
                    
                    
                }
                
            }
      
        gettranslatedtext()
        
    }
    func gettranslatedtext() {
        struct encodeText: Codable {
            var text = String()
        }
        
        let azureKey = "256be96035fe40a3aca306d92c1d39ff"
        
        let contentType = "application/json"
        let traceID = "A14C9DB9-0DED-48D7-8BBE-C517A1A8DBB0"
        let host = "dev.microsofttranslator.com"
        let apiURL = "https://dev.microsofttranslator.com/translate?api-version=3.0&from=" + "en" + "&to=" + "ur"
        
        
        let text2Translate = data
        var encodeTextSingle = encodeText()
        var toTranslate = [encodeText]()
       // let jasonencoder=JSONEncoder()
        
        encodeTextSingle.text = text2Translate
        toTranslate.append(encodeTextSingle)
        
        let jsonToTranslate = try? jasonencoder.encode(toTranslate)
        let url = URL(string: apiURL)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.addValue(azureKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(traceID, forHTTPHeaderField: "X-ClientTraceID")
        request.addValue(host, forHTTPHeaderField: "Host")
        request.addValue(String(describing: jsonToTranslate?.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = jsonToTranslate
        
        let config = URLSessionConfiguration.default
        let session =  URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            if responseError != nil {
                print("this is the error ", responseError!)
                
                let alert = UIAlertController(title: "Could not connect to service", message: "Please check your network connection and try again", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
                
            }
            print("*****")
            self.parseJson(jsonData: responseData!)
        }
        task.resume()
    
    }
    
    func parseJson(jsonData: Data) {
        
        //*****TRANSLATION RETURNED DATA*****
        struct ReturnedJson: Codable {
            var translations: [TranslatedStrings]
        }
        struct TranslatedStrings: Codable {
            var text: String
            var to: String
        }
        
        let jsonDecoder = JSONDecoder()
        let langTranslations = try? jsonDecoder.decode(Array<ReturnedJson>.self, from: jsonData)
        let numberOfTranslations = langTranslations!.count - 1
        print(langTranslations!.count)
        
        //Put response on main thread to update UI
       DispatchQueue.main.async {
       
            self.outputurdu = langTranslations![0].translations[numberOfTranslations].text
        self.performSegue(withIdentifier:"TextShowScreen" , sender: self)
       }
        self.outputurdu = langTranslations![0].translations[numberOfTranslations].text
        print(self.outputurdu)
    }
    func startActivityIndicator()
    {actityIn.isHidden=false
        actityIn.layer.zPosition=1
        imagePic.layer.zPosition=0;
        actityIn.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    func stopActivityIndicator()  {
        actityIn.isHidden=true;
        actityIn.startAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DestinationVC = segue.destination as? NoteShow{
           
                DestinationVC.datareceived = self.outputurdu
            stopActivityIndicator()
            
        }
           
        
        
    }
}


extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let Img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imagePic.image=Img
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}


