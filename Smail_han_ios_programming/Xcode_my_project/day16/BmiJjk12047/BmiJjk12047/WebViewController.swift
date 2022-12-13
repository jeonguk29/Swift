//
//  WebViewController.swift
//  BmiJjk12047
//
//  Created by comsoft on 2022/12/05.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBAction func goGitHub(_ sender: UIButton) {
        let myURL = URL(string:"https://github.com/jeonguk29/jeonguk29")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("webbbbbbbbb") 컨트롤러 실행되자마자 메모리 올라갈때 한번 실행 되는 코드
        let myURL = URL(string:"https://aloe-study.tistory.com/category/APP/Swift")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
    }
    



}
