//
//  MyButton.swift
//  ViewCycle
//
//  Created by Allen H on 2022/01/20.
//

import UIKit

final class MyButton: UIButton {    // 버튼에 참과 거짓 속성을 추가하기 위해 재정의 했음

    var onAndOff = false
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func toggle() {
        self.onAndOff.toggle()      // 토글로 인하여 눌리면 참, 거짓이 계속 바뀜
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function) // 앱을 실행시키면 실제로 1초에 layoutSubviews가 60번 호출 되는 것은 아닌걸 알 수 있음
    }
    
}
