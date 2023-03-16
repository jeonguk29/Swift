//
//  ViewController.swift
//  LoginUIwithCodeProject
//
//  Created by 정정욱 on 2023/03/15.
//

import UIKit

class ViewController: UIViewController {

    // 실무에서 이런 방식 굉장히 선호 : 연관된 코드가 바로 및에 정리가 됨, 코드가 깔끔
    let emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        return view
    }() // 클로저를 담고 동시에 실행
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
    }
    
    func makeUI(){
        

        // 뷰에 올리기
        view.addSubview(emailTextFieldView)
        // 1. 자동으로 잡는 오토레이아웃 끄기 2. 수동으로 오토레이아웃 설정
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
   
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
 
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
     
    }

}

