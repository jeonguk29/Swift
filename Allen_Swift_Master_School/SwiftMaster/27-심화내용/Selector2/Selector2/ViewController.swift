//
//  ViewController.swift
//  Selector2
//
//  Created by Allen H on 2021/11/03.
//

import UIKit

class ViewController: UIViewController {

    // 버튼 관련 속성(변수) 선언 (일단 인스턴스 생성해서 담기)
    let codeButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /*😀
     일반적으로 개발자들이 아래와 같이 UI WKsms gkatnfmf ek rngusgkrh
     viewDidLoad()에서 호출하는 구조로 개발함
     호출 하니까 아래 코드 전체를 viewDidLoad 이안에 쓴거랑 똑같음
     */
    
    // 코드로 짜는 UI관련 함수
    func configureUI() {
        // 버튼 셋팅
        codeButton.setTitle("Code Button", for: .normal)
        codeButton.setTitleColor(.white, for: .normal)
        codeButton.backgroundColor = .blue
        // 자동 제약 잡아주는 것 취소 ===> 코드로 오토레이아웃 잡으려면 필수
        codeButton.translatesAutoresizingMaskIntoConstraints = false
        // 버튼 눌렀을때 실행시킬 함수 연결하기 ⭐️⭐️⭐️
        codeButton.addTarget(self, action: #selector(ViewController.codeButtonTapped), for: .touchUpInside)
       /*
        😀 버튼이 touchUpInside 방식으로 눌렸을때 어떤 메서드로 연결할 것인지 정하는 코드임 왜 이렇게 만드냐면
        스토리 보드로 만들때는. 끌어다 놓기만 하면 자동으로 연결 시켜줬지만
        코드로 만들때는 알아서 해주지 않기때문에 이러한 설정이 필요한 것임
        이러한 매커니즘을 addTarget action 메커니즘이라고 함
        
        codeButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        이 버튼이 눌렸을때 어떤 인스턴스의 메서드를 시킬지 설정하는 함수
        연결 시킬 인스턴스 일반적으로 self 적으면 됨 self는 ViewController를 의미함
        
        그다음 ViewController self 실행 버튼 연결 하면됨
        #selector를 통하여 주소 값을 주는 것
        
        ViewController.codeButtonTapped // ViewController 앞에 명시해줘서 생략 가능함
        
        
        스토리보드로 버튼 만들때랑 코드로 버튼 만들때랑 메커니즘이 이와 같이 조금 다름
        
        */
        
        // 버튼을 화면에 올리기
        // 😀 계층창 보면 ViewController 는 view 변수를 가지고 있는데
        // 앱만들기 할때 완전 바탕이 되는 전체화면이 view임
        // view.backgroundColor = UIColor.gray 예전이 이런거 했었음
        
        view.addSubview(codeButton)
        // 오토레이아웃 코드로 짜기 (지금 중요하지 않음)
        NSLayoutConstraint.activate([
            codeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            codeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30),
            codeButton.widthAnchor.constraint(equalToConstant: 200),
            codeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    // 스토리보드의 버튼이 눌렸을 때 실행되는 함수
    @IBAction func storyBoardButtonTapped(_ sender: UIButton) {
        print("스토리보드 버튼 눌림")
    }
    
    // 코드로 만든 버튼이 눌렸을 때 실행되는 함수
    @objc func codeButtonTapped() { //   @objc 붙여줘야함 오브젝티브 C에서 처리하던 방식이라
        print("코드 버튼 눌림")
    }


}

