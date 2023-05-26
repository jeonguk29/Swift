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
  
    // BMI 저장변수
    private var bmi: BMI?    // 3가지 데이터를 한번에 구조체로 묶었기 때문에 여기서도 3가지 데이터로 한번에 묶어서 처리해야함
    // ⭐️ 접근제어자를 붙였는데 그 이유는 뷰컨 같은 다른 파일에서 bmiManager.bmi 이런식으로 접근하는 것을 막기 위함임 일반적으로  속성은 프라이빗으로 하고 이 속성을 얻기 위해 메서드를 이용함
  
    // BMI얻기 메서드
    mutating func getBMI(height: String, weight: String) -> BMI { // 값 반환 함수랑 분리시켰음, + 구조체에서 저장 속성 변경시 mutating 키워드 필요
        // BMI만들기 메서드 호출
        calculateBMI(height: height, weight: weight)
        // BMI리턴
        return bmi ?? BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white)
    }
    
    // BMI만들기 메서드(BMI수치 계산해서, BMI구조체 인스턴스 만드는 메서드) ⭐️ 기존에 각각 BMI 속성을 얻는 메서드들을 BMI 구조체로 바꾸었기 때문에 한번에 처리 하기 위한 로직으로 바꾼 것임 
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white) // bmi의 설정된 값이 있으면 넘기고 아니면 기본적인 구조체 인스턴스 넘기면 됨
            return
        }
        
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "저체중", matchColor: color)
            
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
            
            
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "과체중", matchColor: color)
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "중도비만", matchColor: color)
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "고도비만", matchColor: color)
        default:
            bmi = BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white)
        }
    }
    
    
   
    
}


/*
 ⭐️ 기존 뷰컨에서 비즈니스 로직을 다 분리한 것임
 그래서 뷰컨은 모델 객체 bmiManager에게 계속 물어보는 것임
 bmiManager야 bmi를 계산해줄래?, 결과 값을 줄래?, 백그라운드 색상을 줄래?, 문자열을 줄래?
 */
