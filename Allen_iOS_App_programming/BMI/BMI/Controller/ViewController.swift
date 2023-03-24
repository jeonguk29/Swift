//
//  ViewController.swift
//  BMI
//
//  Created by 정정욱 on 2023/03/22.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calcalateButton: UIButton!
    
    var bmiManager = BMICalculatorManager() // 이렇게 모델 인스턴스를 찍어서 컨트롤러와, 뷰 객체간의 소통을 할 수 있도록함
     /*
      ⭐️ bmiManager 는 저장속성임 ViewController 의 그러니까 컴파일시 바로 BMICalculatorManager의 인스턴스를 찍어서
      이를 활용하여 소통을 할 수 있는 것임 (모델 객체이용)
      */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해주세요"
        calcalateButton.clipsToBounds = true
        calcalateButton.layer.cornerRadius = 5
        calcalateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }

    
    // ⭐️ 버튼의 액션을 실행 할 뿐만아니라 세그웨이를 직접 연결했기 때문에 관련 메서드도 같이 실행됨
    // BMI계산하기 - 버튼 누르면(다음화면)
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print(#function)
        
        guard let heightText = heightTextField.text, let weightText = weightTextField.text else {return}
        
        /* ⭐️ 이제는 이렇게 구현 할 필요가 없음 모델객체한테 부탁해서 값을 가져오면 되는 것임 비즈니스 모델이 다 거기에 있으니까
        bmi = calculateBMI(height: heightText, weight: weightText)
         */
        bmiManager.calculateBMI(height: heightText, weight: weightText)
        bmiManager.getBMIResult()
    }
    
    // 조건에 따라 다음화면 이동할지/말지  : (직접연결이라 아래 메서드 구현함)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print(#function)
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 다음화면 넘어가기 전에 준비 (일반적으로 데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        // 항상 식별자 먼저 확인
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController // 이미 힙영역에 있는 SecondViewController 로 타입 케스팅
            secondVC.modalPresentationStyle = .fullScreen
            
            // 다음화면으로 데이터 전달
            secondVC.bmiNumber = bmiManager.getBMIResult()
            secondVC.bmiColor = bmiManager.getBackgroundColor()
            secondVC.adviceString = bmiManager.getBMIAdviceString()
        }
        // 다음화면으로 가기전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
   
    
}

extension ViewController: UITextFieldDelegate{
    // 입력하거나 (지우거나) 할때마다 (한글자 한글자 입력하는 순간마다) 호출되는 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        // "숫자"인 경우와 "지우는 경우"만 (글자입력을) 허용 하는 논리
        // (숫자로 변환이 된다면) || (지울때)
        if Int(string) !=  nil || string == "" {
            return true  // 글자 입력을 허용
        }
        return false  // 글자입력 허용하지 않음
    }
    
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder() // 현제 응답 객체 삭제 (즉 키보드 내려감)
            return true
        // 두번째 텍스트필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder() // 응답객체로 만듬
            // 키보드가 올라옴
            return true
        }
        return false
    }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}

