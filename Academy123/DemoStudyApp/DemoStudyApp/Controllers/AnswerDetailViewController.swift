//
//  AnswerDetailViewController.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/07.
//

import UIKit
import WebKit

class AnswerDetailViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var answerName: UILabel!
    
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var questionData: Question?
    
    // 웹뷰 코드
    // URL을 Question모델의 답변 프로퍼티로 불러와 지정

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerName.text = questionData?.questionName
        answerImage.image = questionData?.questionImportance
        
        let myURL = URL(string:questionData?.questionAnswer ?? "아직 준비중이에요")
              let myRequest = URLRequest(url: myURL!)
              webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    
 
   

}
