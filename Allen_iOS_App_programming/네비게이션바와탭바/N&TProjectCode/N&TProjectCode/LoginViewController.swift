//
//  ViewController.swift
//  N&TProjectCode
//
//  Created by Allen H on 2022/01/10.
//

import UIKit

class LoginViewController: UIViewController {

    // 로그인 버튼
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 굳이 뷰를 따로 만들지 않았음 (MVC패턴으로 만들지 않았음)
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    // UI설정하는 코드, 버튼의 오토레이아웃
    func makeUI() {
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    // ⭐️ 이 아래코드가 전부 탭바 + 네비게이션바 코드임
    // 버튼 누르면 동작하는 코드 ===> 코드로 탭바 + 네비게이션바 설정
    @objc func nextButtonTapped() {
        // 탭바컨트롤러의 생성
        let tabBarVC = UITabBarController()
        
        // 첫번째 화면은 네비게이션컨트롤러로 만들기 (기본루트뷰 설정)
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        let vc4 = FourthViewController()
        let vc5 = FifthViewController()
        
        // 탭바 이름들 설정
        vc1.title = "Main"
        vc2.title = "Search"
        vc3.title = "Post"
        vc4.title = "Likes"
        vc5.title = "Me"
        
        // 탭바로 사용하기 위한 뷰 컨트롤러들 설정
        // tabBarVC.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, animated: <#T##Bool#>) 보면 UIViewController를 상속 받는 애들이 여기로 옴
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.backgroundColor = .white
        
        // 탭바 이미지 설정 (이미지는 애플이 제공하는 것으로 사용)
        guard let items = tabBarVC.tabBar.items else { return } // 옵셔널로 되어 있기 때문에 벗기고 그다음 원소들을 추가함
        
        items[0].image = UIImage(systemName: "square.and.arrow.up") // systemName 생성자 사용시 애플이 미리 만든 이미지들을 사용 할 수 있음
        items[1].image = UIImage(systemName: "folder")
        items[2].image = UIImage(systemName: "ellipsis.message.fill")
        items[3].image = UIImage(systemName: "doc")
        items[4].image = UIImage(systemName: "note")
        
        // 프리젠트로 탭바를 띄우기
        present(tabBarVC, animated: true, completion: nil)
    }

}
