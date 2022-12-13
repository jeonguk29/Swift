//
//  ComViewController.swift
//  BmiJjk12047
//
//  Created by comsoft on 2022/12/12.
//

import UIKit
import WebKit

class ComViewController: UIViewController {

    @IBOutlet weak var comView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://gall.dcinside.com/board/lists/?id=extra_new1")
        let myRequest = URLRequest(url: myURL!)
        comView.load(myRequest)

        // Do any additional setup after loading the view.
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
