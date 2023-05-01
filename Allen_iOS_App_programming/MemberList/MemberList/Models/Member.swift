//
//  Member.swift
//  MemberList
//
//  Created by 정정욱 on 2023/05/01.
//

import UIKit

// 간단한 데이터 모델은 구조체로 다 만듬
struct Member{
    
    // 지연 저장속성 사용시 나중에 메모리가 생김
    lazy var memberImage: UIImage? = {
        guard let name = name else { // 이름이 없으면 애플이 기본 제공해주는 이미지 저장
            return UIImage(systemName: "person")
        }
        
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
        // 아니면 해당 이름으로 된 이미지를 담아주고 재대로 생성하지 못한 경우 애플이 기본 제공해주는 이미지 저장
    }() // 클로저를 활용
    
    
    
    // 멤버의 (절대적) 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    // 구조체는 직접 생성자를 구현 하지 않아도 멤버 이니셜 라이즈 생성자를 제공했음 (저장 속성을 모두 초기화 할수 있는)
    // 하지만 특정 로직을 위해 직접 생성자를 구현함
    
    init(name: String? = nil, age: Int? = nil, phone: String? = nil, address: String?) {
        
        // 0일때는 0, 0이 아닐때는 타입 저장속성의 절대 값으로 셋팅 (자동순번)
        
        self.memberId = Member.memberNumbers 
        
        // 나머지 저장속성은 외부에서 셋팅
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        
        // 멤버를 생성한다면, 항상 타입 저장속성의 정수값 + 1
        Member.memberNumbers += 1
    }
}
