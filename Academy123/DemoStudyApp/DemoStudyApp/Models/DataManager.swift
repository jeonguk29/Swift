//
//  DataManager.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/07.
//

import UIKit

class DataManager {
    var questionDataArray: [Question] = []
    
    
    func makeQuestionData() {
        
        questionDataArray = [
            Question(questionName: "@Main에 대해서 설명하시오.", questionAnswer: "https://green1229.tistory.com/265", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "실제 디바이스가 없을 경우 개발 환경에서 할 수 있는 것과 없는 것을 설명하시오.", questionAnswer: "https://hyun083.tistory.com/71", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "app의 not running, inactive, active, background, suspended에 대해 설명하시오.", questionAnswer: "https://aloe-study.tistory.com/202", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "앱이 In-Active 상태가 되는 시나리오를 설명하시오.", questionAnswer: "", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "scene delegate에 대해 설명하시오", questionAnswer: "", questionImportance: UIImage(named: "Image1"))
        ]
        
    }
    
    func getQuestionData() -> [Question]{
        return questionDataArray
    }
}
