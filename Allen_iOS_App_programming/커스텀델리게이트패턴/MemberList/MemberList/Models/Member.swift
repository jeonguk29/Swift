//
//  Member.swift
//  MemberList
//
//  Created by 정정욱 on 2023/05/01.
//

import UIKit

//⭐️ 커스텀 델리게이트 1단계
// 커스텀 델리게이트 패턴을 사용하기 위해 프로토콜을 만듬
// 이것을 DetailViewController에서 새로운 멤버가 추가 된다면
// 데리자인 ViewController가 사용할 것임
protocol MemberDelegate: AnyObject{
    //⭐️ 커스텀 델리게이트 5단계
    //AnyObject를 채택해야지만 클래스타입만 채택 할 수 있고 프로토콜 타입 선언 할때 weak으로 선언가능
    func addNewMember(_ member: Member)
    func update(index:Int, _ member: Member)
    
}
// DetailViewController 에서는 멤버가 추가되거나, 업데이트 되는일 2가지 동작이 일어 날 것임
// 그럼 데리자한테 이런일이 발생했으니 너가 무엇을 해야해라고 알려주는 것임
// ViewController에서는 그일을 실제로 처리하는 것을 구현해줘야함
// 이게 델리게이트 패턴의 핵심임



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
    
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
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
