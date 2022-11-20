//
//  ViewController.swift
//  woogie_project1
//
//  Created by comsoft on 2022/11/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
//    @IBAction func clear(_ sender: UIButton) {
//        lblHello.text = ""
//        txtName.text = ""
//    }
    @IBAction func btnSend(_ sender: UIButton) {
        if sender.tag == 1
        {
            lblHello.textColor = UIColor.green
            lblHello.text = "HELLO, " + txtName.text!
            print(lblHello.text, txtName.text)
        }
        else if sender.tag == 2 {
            lblHello.text = ""
            txtName.text = ""
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


