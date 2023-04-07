//
//  AvatarDataManager.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/07.
//

import UIKit

class AvatarDataManager {
    var avatarDataArray: [AvatarQuestion] = []
    
    
    func makeQuestionData() {
        
        avatarDataArray = [
            AvatarQuestion(avatarQuestionName: "iOS ViewController 생명주기", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "Frame과 Bounds의 차이", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            AvatarQuestion(avatarQuestionName: "@Main에 대해서 설명하시오.", avatarQuestionImage:  UIImage(named: "ViewController생명주기")),
            
        ]
        
    }
    
    func getQuestionData() -> [AvatarQuestion]{
        return avatarDataArray
    }
}
