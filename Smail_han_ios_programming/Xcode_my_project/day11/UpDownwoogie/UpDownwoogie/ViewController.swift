//
//  ViewController.swift
//  UpDownwoogie
//
//  Created by comsoft on 2022/11/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblNumber: UILabel!
    var x = 0
    
    @IBAction func btnUp(_ sender: UIButton) {
        x = x + 1
        lblNumber.text = String(x)
    }
    
    @IBAction func btnDown(_ sender: UIButton) {
        x = x - 1
        lblNumber.text = String(x)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

