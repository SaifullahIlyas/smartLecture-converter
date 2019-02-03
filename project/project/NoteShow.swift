//
//  NoteShow.swift
//  project
//
//  Created by MAC on 22/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import PDFKit
import PDFGenerator


class NoteShow: UIViewController {
var datareceived = ""
    @IBOutlet weak var NotesData: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotesData.text=" "
        NotesData.text=datareceived;

        
    }
    
    @IBAction func Pdf(_ sender: Any) {
        generatePDF()
        
    }
    
    func generatePDF() {
        let v1 = UIScrollView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 100.0))
        let v2 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
        let v3 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
        //let v4=NotesData
        v1.backgroundColor = .red
        v1.contentSize = CGSize(width: 100.0, height: 200.0)
        v2.backgroundColor = .green
        v3.backgroundColor = .blue
        
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        print(dst)
        // outputs as Data
        do {
            let data = try PDFGenerator.generated(by: [v1, v2,v3])
            try data.write(to: dst, options: .atomic)
        } catch (let error) {
            print(error)
        }
        
        // writes to Disk directly.
        do {
            try PDFGenerator.generate([v1, v2, v3], to: dst)
        } catch (let error) {
            print(error)
        }
    }

}
