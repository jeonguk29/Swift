//
//  ThirdViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var someString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = someString // 전화면에서 데이터 전달 받은것을 표시하는 역할을 함

    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
    }
    
  
    
}
