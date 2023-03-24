//
//  ViewController.swift
//  LoginProject
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

final class ViewController: UIViewController {
    
    private let loginView = LoginView() // 이렇게 하면 여기에 로그인 뷰가 담겨있을 것임
    // 그렇다면 이게 뷰임
    
    override func loadView() {  // ⭐️ loadView메서드는 viewDidLoad보다 먼저 호출 되는 녀석임
        // super.loadView() 필요없음
        view = loginView
        
        //⭐️ ViewController 안에는 항상 기본 뷰가 있었는데 그걸 교체시켜주는 것임
        // 정리하자면 UI를 코드로 만들었다면 해당 코드는 따로 뷰영역에 빼두고 뷰컨에는 뷰컨이 할 수 있는 일들만 구현을 해줘야함 그때 해줄 수 있는데
        // 바로 위와 같은 뷰교체임
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print()
        setupAddTarget()
    }
    
    // 버튼 이벤트 처리를 전달 받는 곳
    func setupAddTarget() {
        //  loginView.loginButton 분석 = loginView는 현제 우리의 기본뷰 내부에 버튼이 올라가 있을 것임
        // 그때 addTarget연결은 컨트롤러에서 해줄 수가 있는 것임
        // addTarget 은 #selector를 사용해서 다른 함수를 연결 하는 것임 스토리 보드로 구현시에는 내부적으로 알아서 액션 처리를 해준다고 했음
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    // 로그인 버튼 누르면 동작하는 함수
    @objc func loginButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
        
        // 내부에서 아래 처럼 처리 가능 함 위에서 액션 연결을 해주면  다음 화면으로 넘어가는 것음 무조건 컨트롤러에서 해줘야함
        //present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        // 왜냐 다음 화면 넘어가는 코드들은 ex present 는 UIView 이런데 없고 UIViewController 이곳게 있기 때문임
    }
    
    // 리셋버튼이 눌리면 동작하는 함수
    @objc func resetButtonTapped() {
        //만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
    
}


