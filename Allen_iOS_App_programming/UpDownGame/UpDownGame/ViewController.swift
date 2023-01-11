//
//  ViewController.swift
//  UpDownGame
//
//  Created by 정정욱 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    // 컴퓨터가 랜덤으로 숫자 선택
    var comNumber = Int.random(in: 1...10) // 이코드가 viewDidLoad() 에 있으면 안되는 이유 viewDidLoad() 또한 함수라 스택에 올라가서 사라지면 끝남 우리는 이 값을 앱 전역에서 가지고 놀기위해 여기다 선언 하는것임

//    var myNumber: Int = 1 // 1을 넣은 이유는 0으로 초기화 하고 사용자가 Select 버튼을 눌렀을때 오류가 날 수 있기 때문임
//
    
    // 앱의 화면에 들어오면 가장 처음에 실행 되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1) 메인 레이블에 "선택하세요"
        mainLabel.text = "선택하세요"
        // 2) 숫자 레이블은 ""
        numberLabel.text = ""
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        // 1) 버튼의 숫자를 가져와야함
        guard let numString = sender.currentTitle else { return }
        
        // 2) 숫자 레이블이 변하도록 (숫자에 따라)
        numberLabel.text = numString
        // 3) 선택한 숫자를 변수에다가 저장 (선택)
        
//        guard let num = Int(numString) else { return }
//
//        myNumber = num // 가드랫 바인딩 장점 아래서 바로 사용 가능함
//
        
    }
    
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        // 또 다른 방법 제시
        // 숫자레이블에 있는 문자열 가져오기(옵셔널 벗기기)
        guard let myNumSting = numberLabel.text else { return }
        guard let myNumber = Int(myNumSting) else { return }
        
        // 1 컴퓨터의 숫자와 내가 선택한 숫자를 비교 UP / Down / Bingo (메인 레이블)
        
        if comNumber > myNumber {
            mainLabel.text = "Up"
        }else if comNumber < myNumber{
            mainLabel.text = "Down"
        }else{
            mainLabel.text = "Bingo🤩"
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 1) 메인레이블 "선택하세요"
        mainLabel.text = "선택하세요"
        // 2) 숫자레이블 "" (빈문자열)
        numberLabel.text = ""
        // 3) 컴퓨터의 랜덤숫자를 다시 선택하게
        comNumber = Int.random(in: 1...10)
  
     
        
    }
}

