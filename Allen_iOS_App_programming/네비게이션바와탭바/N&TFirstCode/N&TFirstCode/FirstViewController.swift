//
//  ViewController.swift
//  N&TFirstCode
//
//  Created by Allen H on 2022/01/10.
//

import UIKit

// ⭐️ FirstViewController 자체에 네비게이션 컨트롤러랑 탭바 컨트롤러를 넣어 놓는 것임
class FirstViewController: UIViewController {

    // 로그인 여부에 관련된 참/거짓 저장하는 속성
    var isLoggedIn = false
    
    //var navigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        makeUI()
        
        // ⭐️ 로그인이 되어있지 않다면 로그인화면 띄우기
        // =====> viewDidAppear가 더 정확한 시점 (뷰가 뜬 다음으로 코드 옮기기) ⭐️⭐️⭐️
        
//        if !isLoggedIn {
//            let vc = LoginViewController()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: false, completion: nil)
//        }

    }
    
    // 다음화면을 띄우는 더 정확한 시점 ⭐️⭐️⭐️
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ⭐️ 로그인이 되어있지 않다면 로그인화면 띄우기
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
    }
    
    
    func makeUI() { 
        view.backgroundColor = .gray
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        //appearance.backgroundColor = .brown     // 색상설정
        
        //appearance.configureWithTransparentBackground()  // 투명으로
        
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "Main"
        
        // ⭐️ 코드로 나중에 present 말고 네비게이션의 navigationController를 사용하여 화면 이동시
//        let vc = LoginViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.popViewController(animated: true)
//        // navigationController 를 이용하여 화면 이동 내부적으로 스택 동작 push로 화면을 쌓고 부르고 거기서 다시 이전 화면으로 돌아올때는
//        // dismiss(animated: <#T##Bool#>) 가 아닌 pop으로 돌아오면 됨 UIViewController에 navigationController 라는 저장 속성을 미리 만든 것임
//        // 뷰컨을 사용했다면 이런 설정 쓰라고
        // 스토리보드로 만들때 세그웨이 누를때 Show라고 있는 것은 아이패드같이 큰화면에서 설정에 들어가 어떤 버튼을 누르면 오르쪽 화면에 바로 나타나는 것을 말할때 쓰는 개념
        // 아이폰 같은 작은 화면에서 누를때는 push라는 방식으로 화면이 넘어가는 방법으로 구현 되어 있음
    }
    
    
    

}
