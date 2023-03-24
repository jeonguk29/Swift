//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by 정정욱 on 2023/03/24.
//

import UIKit


// BMI앱의 비즈니스 모델은 BMI 계산임 그 부분을 여기에 구현을 할것임
// 기존에 뷰컨에서 비엠아이 계산 로직을 다가져옴
// ⭐️ 역할 BMI 계산해내고 그것에 맞는 결과값, 컬러, 문자열을 전달해주는 역할을 함


/*
 구조체로 만들던 클래스로 만들던 큰 상관은 없지만 큰 프로젝트를 할때는 힙에 저장 되는게 좋음
 이 비즈니스 로직과 관련된 코드에 여러개의 뷰컨트롤러에서 접근 할거기 때문에 그때는 클래스로 만드는게 좋음
 지금은 프젝 단위가 작고 하나의 뷰컨에서 모델에 접근 하기때문에 구조체로 만듬 실무에서는 class 많이 사용함  
 */
struct BMICalculatorManager{
    var bmi: Double?    // 메니져가 하는 역할이 이 bmi 숫자를 관리하는 거라 이 변수 또한 가져옴
    
  
    
    // BMI계산 메서드
    mutating func calculateBMI(height: String, weight: String){  // 값 반환 함수랑 분리시켰음, + 구조체에서 저장 속성 변경시 mutating 키워드 필요
        
        guard let h = Double(height), let w = Double(weight) else {
            bmi = 0.0
            return
        }
        var bmiNumber = w / (h * h) * 10000
        bmi = round(bmiNumber * 10) / 10
        //print("BMI결과값: \(bmi)")
        //return bmi
    }
    
    // 계산된 값을 넘겨주는 함수
    func getBMIResult() -> Double {
        return bmi ?? 0.0 // nil 이면 기본값 지정
    }
    
    // 색깔 얻는 메서드
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    // 문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
}


/*
 ⭐️ 기존 뷰컨에서 비즈니스 로직을 다 분리한 것임
 그래서 뷰컨은 모델 객체 bmiManager에게 계속 물어보는 것임
 bmiManager야 bmi를 계산해줄래?, 결과 값을 줄래?, 백그라운드 색상을 줄래?, 문자열을 줄래?
 */
