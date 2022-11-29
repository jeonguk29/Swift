//
//  ViewController.swift
//  BmiJjk12047
//
//  Created by comsoft on 2022/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtHeight: UITextField!
   
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchOnOff(_ sender: UISwitch) {
        if sender.isOn{
            print("On")
        }else{
            print("Off")
        }
    } // 보통 이렇게 함수로 만들어 스위치를 사용하고 On/Off일 때에 따라 다르게 동작하게 만들수 있음 여자용, 남자용 / 한글, 영어
    @IBAction func sc(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("남성")
        }else {
            print("여성")
        }
    }
    
    @IBAction func calcBmi(_ sender: UIButton) {
        //let weight = 60.0
        //let height = 170.0
        
        if txtWeight.text == "" || txtHeight.text == ""{
            // 둘중 하나라도 비어 있으면
            lblResult.textColor = UIColor.red // 텍스트 칼라도 빨간색으로 지정
            lblResult.text = "키와 몸무게를 입력하세요!!"
            return // 여기서 탈출 시켜버림 끝내버림 위에 안내 나오게 하고
        }else {
            
            let weight = Double(txtWeight.text!)!
            let height = Double(txtHeight.text!)!
            // 시험 왜 ! ! 두개 쓰는지 배점 큼
            // 클레스 소스 15페이지도 시험
            
            let bmi = weight / (height*height*0.0001) // kg/m*m
            let shortenedBmi = String(format: "%.1f", bmi)
            var body = ""
            
            var color = UIColor.white
            
            if bmi >= 40 {
                color = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                // color = UIColor.red 이렇게 하는 거랑 같음 하나만 줄때는
                body = "3단계 비만"
            } else if bmi >= 30 && bmi < 40 {
                color = UIColor(displayP3Red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
                body = "2단계 비만"
            } else if bmi >= 25 && bmi < 30 {
                color = UIColor(displayP3Red: 0.4, green: 0.0, blue: 0.0, alpha: 1.0)
                body = "1단계 비만"
            } else if bmi >= 18.5 && bmi < 25 {
                color = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
                //color = UIColor.blue
                body = "정상"
            } else {
                color = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                body = "저체중"
            }
        //    print("BMI:\(shortenedBmi), 판정:\(body)")
            lblResult.backgroundColor = color
           // lblResult.textColor = UIColor.green 이렇게 색 바꿀수 있음
            lblResult.clipsToBounds = true // 아래 라운드 주기전 무조건 해줘야함
            lblResult.layer.cornerRadius = 10 // 이렇게 소스에서 깍는게 더 좋은 방법
            lblResult.text = "BMI:\(shortenedBmi), 판정:\(body)"
        
        }
    }
    
}

