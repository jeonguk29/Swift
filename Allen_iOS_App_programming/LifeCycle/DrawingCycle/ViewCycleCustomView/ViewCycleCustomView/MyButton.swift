//
//  MyButton.swift
//  ViewCycleCustomView
//
//  Created by Allen H on 2022/01/22.
//

import UIKit

final class MyButton: UIButton {
    
    // 버튼(뷰) 내부에 오토레이아웃을 잡을 필요가 있다면 여기 구현
//    override func updateConstraints() {
//
//        // 구현시 여기에 구현 ⭐️
//
//        super.updateConstraints() // 나중에 호출 ⭐️
        // ⭐️ 보통 상위에 있는걸 먼저호출하고 구현을 아래에 하는데 이녀석은 다름 구현후 마지막에 상위 부모의 것을 호출함
//    }
    
    
    // ⭐️ 버튼을 둥글게 깍는 코드를 layoutSubviews 안에다 구현한 이유는 아래와 같음 (정확한 시점에 넣어야만 재대로 깍을 수가 있는 것임 위에다 구현하면 깍이지 않음)
    
    // 현재 화면크기를 기준으로 프레임이 잡히는 곳(버튼 프레임이 결정)     :   즉 모든 화면이 결정 나는 시점
    // 버튼을 넓이 기준으로 깍는 것이 가능(넓이 프레임이 결정되니까)
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.layer.cornerRadius = self.frame.width / 2
//        // self.layer.cornerRadius = 숫자 커질수록 점점 둥글게 깍임 완벽하게 반으로 깍기 위해 .width / 2 반을 나눠서 둥글게 그리게 둔것
//    }
//    
    // 내부 컨텐츠를 그리는 곳
    // (예를 들어, draw메서드 내에 코드로 구현해서 별모양을 그린다던지, 할 수 있음)
//    override func draw(_ rect: CGRect) {
//        <#code#>
//    }
    
}
