//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 정정욱 on 2023/03/14.
//

import UIKit

// 😀 UITextFieldDelegate라는 자격증을 채택해야 텍스트 필드를 제대로 사용할 수 있음
/*
 텍스트 필드는 따로 존재하는 객체라고 생각해야함 유저가 입력하는 것들을 다 파악 및 동작처리를  뷰컨트롤러에 전달해서 그 결과를 보여준다고 생각하면 됨
 그 동작 처리를 하는 것을 대리자라고 하는데 아래와 같이
 textField.delegate = self  이런식으로 대리자를 지정함
 그래서 대리자는 뷰컨의 인스턴스임
 
 즉
 1. UITextFieldDelegate 프로토콜 채택
 2.  textField.delegate = self 누가 대리자인지 지정
 3. textFieldShouldBeginEditing 와 같은 함수들을 구현하며 독립적 텍스트 필드 객체에서 넘어오는 이벤트들을 실제로 처리
 */
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self // 그래서 텍스트 필드의 대리자는 뷰컨트롤러임
            // self 는 ViewController 임
        setUP()
        
    }
    
    // ⭐️ ViewController에 즉 상위에 정의 된 메서드임 다른 부분 선택시 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 다른 부분 선택시 뷰를 끝내겠다.
        //textField.resignFirstResponder() // 사실 이코드랑 비슷함
        // 위는 뷰 전체를 종료 아래는 텍스트필드를 종료
    }
    
    // 😆 UITextFieldDelegate라는 자격증을 채택했는데 빨간줄이 없음 필수적 구현이 아니라
    // 현제 선택적 구현으로 되어 있는것임
    // 아래 코드도 우리가 UITextFieldDelegate 를 채택해서 선택적 구현한 것임
    
    // 텍스트 필드의 입력을 시작할때 호출 (시작할지 말지의 여부를 허락하는 것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 -
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트 필드의 입력을 시작했다.")
    }
    
    // 입력할 것을 조건에 따라 지우게 할지 말지 정하는 메서드
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return false
    }

    // 텍스트필드 글자 내용이 (한글자 한글자) 입력 되거나 지워질때 호출이 되고 (허락)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(#function)
//        print(string)
        
//        let maxLength = 10
//            let currentString: NSString = (textField.text ?? "") as NSString
//            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
//
//            return newString.length <= maxLength
//
        
        // 입력되고 있는 글자가 "숫자"인 경우 입력을 허용하지 않는 논리
        if Int(string) != nil {  // (숫자로 변환이 된다면 nil이 아닐테니)
            return false
        } else {
            // 10글자이상 입력되는 것을 막는 코드
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        
//        // 10글자이상 입력되는 것을 막는 코드 (또다른 구현법)
//        if (textField.text?.count)! + string.count > 10 {
//            return false
//        } else {
//            return true
//        }
        

    }
    
    // 텍스트필드의 엔터키가 눌러지면 다음동작을 허락할것인지 말것인지 (엔터키를 눌리게 할지 말지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        // 아무것도 입력하지 않았으면 엔터 처리하지 않음
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        }else{
            return true
        }
    }
    
    // 텍스트필드의 입력이 끝날때 호출 (끝날지 말지를 허락)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 입력이 실제 끝났을때 호출 (시점)
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트 필드의 입력을 끝냈다.")
        textField.text = "" // 입력이 끝나면 다시 비어있게
    }
    
    
    
    func setUP(){
        view.backgroundColor = UIColor.gray
        /*
         view 라는 속성은 상의 UIViewController Class 에 이미 정의가 되어 있는 것임 이게 무엇을 의미하냐면
         ViewController에는 기본적으로 가장 하위에 view 가 하나 깔려 있는데 이게 저 스토리 보드를 의미하는 것임 왼쪽 계층뷰를 보면
         ViewController 하위에 View가 있는 것을 볼 수 있음
         */
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect // 텍스트 필드의 테두리 등 을 바꿀 수 있음
        textField.clearButtonMode = .always // 입력중 언제나 지울수 있게
        textField.returnKeyType = .join
        
        // 앱시작하는 순간 키보드가 올라옴
        textField.becomeFirstResponder() // textField너는 첫번째로 응답 하는 객체가 되야해 알려주는 것임
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // 버튼 누르면 키보드가 내려감
        textField.resignFirstResponder()
        // 텍스트 필드를 응답객체에서 사임한다.
    }
    
}

