//
//  ViewController.swift
//  ViewCycle
//
//  Created by Allen H on 2022/01/20.
//

import UIKit

final class ViewController: UIViewController {
    
    // 제약조건을 저장하기 위한 변수 선언
    // (나중에 접근해서 변경하기 위함)
    private var btnHeightAnchor : NSLayoutConstraint!
    private var btnWidthAnchor: NSLayoutConstraint!
    
    // 버튼
    private lazy var myButton: MyButton = {
        let button = MyButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .yellow
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleAnimationEffect), for:.touchUpInside)    // 버튼 누르면 해당 함수 실행
        button.onAndOff = false // 처음 꺼짐으로 해둠
		        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(myButton)
    }
    
    func setupConstraints() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 원칙적인 오토레이아웃 설정 (높이, 넓이)
        //myButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //myButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 제약조건을 변수에 저장
        btnHeightAnchor = myButton.heightAnchor.constraint(equalToConstant: 60)
        btnWidthAnchor = myButton.widthAnchor.constraint(equalToConstant: 100)
        
        btnHeightAnchor.isActive = true     // 트루면 위에서 정한 제약 조건이 실행됨
        btnWidthAnchor.isActive = true
        
        // 원칙적인 오토레이아웃 설정 (가운데 정렬 - X, Y축)
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func handleAnimationEffect(){
        print(#function)
        
        // 높이/넓이 변경 관련 애니메이션 코드
        if !myButton.onAndOff {
            btnHeightAnchor.constant = 400
            btnWidthAnchor.constant = 200
        } else {
            btnHeightAnchor.constant = 60           // 눌리면 오토레이아웃 설정을 변경 하고 있고
            btnWidthAnchor.constant = 100
        }
        
        UIView.animate(withDuration: 2) {   // ⭐️ 해당 함수를 실행함 2초동안 애니매이션 효과를 주면서 지금 다시 그리도록함
            self.view.layoutIfNeeded()  // layoutIfNeeded 함수는 0.016 초 못기다리겠으니까, 지금 당장 위치/크기 조정 해줘      호출 시
            // => 자동으로 layoutSubviews 지금 당장 호출함 (하위뷰의) 레이아웃: 위치 / 크기 (재)조정
            // 배치 지금 당장 다시하는 것을 2초동안해 라는 것임 
        } completion: { success in
            print("애니메이션 처리 완료")
        }
        
        myButton.toggle()   // 켰다 껏다 반복
    }
    
}

/*
 뷰컨트롤러와 뷰(UIView)의 Drawing Cycle이 아주 긴밀하게 동시에 짜여서 돌아감
 115P
 */
