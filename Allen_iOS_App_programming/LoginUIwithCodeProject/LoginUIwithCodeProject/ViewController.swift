//
//  ViewController.swift
//  LoginUIwithCodeProject
//
//  Created by 정정욱 on 2023/03/15.
//

import UIKit

class ViewController: UIViewController {

    // 생성자를 통해 UIView를 변수에다 담은 실제로 화면에 아직 올라간건 아님 메모리에만 있는 것
    let emailTextFieldView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
    }
    
    func makeUI(){
        // 이렇게 다양한 설정을 해줄 수 있지만
        emailTextFieldView.backgroundColor = UIColor.darkGray
        // 가장 중요한건 설정만 한다고해서 진짜 view에 올라가지는 않음 화면 보이지 않는다는 것임
        /*
         ⭐️ ViewController 하위에 있는 기본 view에 올리는 메서드가 있음
         이렇게 올려놔야지만 실제로 화면에 표시가 되는것임
         스토리보드에서 올리면 이러한 처리까지 자동으로 됬던것임
         */
        view.addSubview(emailTextFieldView)
        
        
        //⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️ 우리가 코드로 UI를 짜면 자동으로 코드로 짠 emailTextFieldView가
        // 오토레이아웃이 잡혀버림 이 자동으로 잡아주는 오토레이아웃 기등을 끄는 것임 그래야 우리가
        // 설정한 오토레이아웃이 적용됨 정리 1. 자동으로 잡는 오토레이아웃 끄기 2. 수동으로 오토레이아웃 설정
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // ⭐️ 여기서 끝이아님 오토레이아웃도 설정해줘야함 : 화면 어디에 올릴지 몰라서
        
        // 왼쪽
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        // equalTo 이라는건 오토레이아웃을 잡을때 꼭 필요한 기준점을 말하는데 어디에 기준을 둘지
        // 앞에 다른 뷰가 있으면 거기에 둘지 아니면 기본 뷰를 기준으로 둘지등을 정할 수 있음
        // .isActive = true 는 애플이 정의한 활성화 코드임 : 해당 설정을 활성화 앞쪽으로 부터 30 뛴다
        
        
        //오른쪽
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        // 뒤쪽에서 맞출때는 보통 - 붙이면됨
        
        
        // 위쪽
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        // 높이
        // 높이는 기준이 없음 어디서부터 얼마큼 띄어야 하는지
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // 해당 숫자에 맞춰줌
    }

}

