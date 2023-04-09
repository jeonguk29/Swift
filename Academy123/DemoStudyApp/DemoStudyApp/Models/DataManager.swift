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
            Question(questionName: "앱이 foreground에 있을 때와 background에 있을 때 어떤 제약사항이 있나요?", questionAnswer: "", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "상태 변화에 따라 다른 동작을 처리하기 위한 앱델리게이트 메서드들을 설명하시오.", questionAnswer: "", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "앱이 In-Active 상태가 되는 시나리오를 설명하시오.", questionAnswer: "", questionImportance: UIImage(named: "Image1")),
            Question(questionName: "scene delegate에 대해 설명하시오", questionAnswer: "", questionImportance: UIImage(named: "Image1"))
        ]
        
    }
    
    func getQuestionData() -> [Question]{
        return questionDataArray
    }
}
