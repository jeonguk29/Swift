//
//  FirstViewController.swift
//  NextVC
//
//  Created by 정정욱 on 2023/03/17.
//

import UIKit

class FirstViewController: UIViewController {
    
    let mainLabel = UILabel()
    
    var backButton: UIButton = {
        let button = UIButton(type: .custom)
        // 버튼 관련 설정
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var someString: String? // 일반적으로 데이터 전달 받을때 옵셔널로 선언 많이함(초기값 nil로 선언) 옵셔널이 아니면 생성자를 다시 만들어줘야함
    // UIViewController를 상속받아 저장속성을 만들었는데 기본값이 없기 때문임 : (지정생성자가 없다고 오류남)
    // override init 해서 만들어 줘야함

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //mainLabel.text = someString
        setUp()
        makeAutoLayout()
    }
    
    func setUp(){
        mainLabel.text = someString // mainLabel.text 자체가 원래부터 옵셔널 스트링 형이라 옵셔널 바인딩 따로 필요 없음
        mainLabel.font = UIFont.systemFont(ofSize: 22)
        
        view.addSubview(mainLabel)
        view.addSubview(backButton)
        
        view.backgroundColor = .gray
        
    }
    
    func makeAutoLayout() {
   
        
        // 레이블 오토레이아웃
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        

        
        // 버튼 오토레이아웃
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)       // 우리가 화면을 넘어갈때는 present 라는 메서드가 있었는데
        // 다시 전 화면으로 넘어가는 메서드가 있음 dismiss (해고하다), 애니메이션 설정을 해주고, 다 끝난다음에 아무것도 시키지 않음
    }

}
