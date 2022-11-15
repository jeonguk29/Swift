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
    
    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "HELLO, " + txtName.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

