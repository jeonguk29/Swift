//
//  MyView.swift
//  ViewCycleCustomBtn
//
//  Created by Allen H on 2022/01/22.
//

import UIKit

class MyView: UIView {
    
    var onAndOff = false    // 뷰 자체에 켰다, 껏다 가능한 속성 추가
    
    // 버튼
    lazy var myButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .blue      // 파랑이 버튼 뷰가 노랑임
        button.setTitle("Touch", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    func toggle() {
        self.onAndOff.toggle()
    }
    
    // 생성자의 재정의
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(myButton)
        myButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 생성자를 재정의시, 필수생성자도 반드시 구현
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ⭐️ 버튼의 넓이와 높이를 오토레이아웃으로 맞춘다면
    override func updateConstraints() {     // 오토레이아웃으로 버튼의 넓이와 높이를 뷰의 50%로 잡음
        print(#function)
        myButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        myButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        myButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        super.updateConstraints()
    }
    
    // ⭐️ 버튼의 넓이와 높이를 프레임기준으로 맞춘다면     여기에다 구현을 해야함 (결과는 동일)
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        print(#function)
//
//        myButton.frame.size = CGSize(width: self.frame.size.width/2, height: self.frame.size.height/2)
//        myButton.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//    }
    
    
   // ⭐️ 시점상으로 보면 가장 나중임
//    override func draw(_ rect: CGRect) {
//        <#code#>
//    }
//
}
