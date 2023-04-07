//
//  AnswerViewController.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/07.
//

import UIKit
import WebKit

class AnswerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var answerName: UILabel!
    
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var questionData: Question?
    
    // 웹뷰 코드
    // URL을 Question모델의 답변 프로퍼티로 불러와 지정
    override func loadView() {
           let webConfiguration = WKWebViewConfiguration()
           webView = WKWebView(frame: .zero, configuration: webConfiguration)
           webView.uiDelegate = self
           view = webView
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetUp()
        // Do any additional setup after loading the view.
    }
    
    func uiSetUp(){
        answerName.text = questionData?.questionName
        answerImage.image = questionData?.questionImportance
        
        let myURL = URL(string:questionData!.questionAnswer)
              let myRequest = URLRequest(url: myURL!)
              webView.load(myRequest)
    }
    
   
    



}
