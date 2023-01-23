import UIKit

/*:
 # Part14 - 확장(Extensions)
 */
/*:
 ## 확장(Extensions)
 * 확장의 개념에 대한 이해
 ---
 */
/**=================================================================================
 - 상속과 확장의 비교
 - (상속 - 수직적 개념) 성격이 비슷한 "타입을 새로"만들어, 데이터를 추가하고, 기능(메서드)을 변형시켜 사용하려는 것
 - (확장 - 수평적 개념) "현재 존재하는 타입"에 기능(메서드)을 추가하여 사용하려는 것
 
 
 - 현재 존재하는 타입
 - 1)클래스, 2)구조체, 3)열거형 (그리고 프로토콜) 타입에 확장(새로운 기능 추가)이 가능함
 - (새 기능을 추가 할 수 있지만 기존 기능을 재정의 할 수는 없음)
 
 
 - 확장의 장점
 - 원본 소스 코드에 대한 액세스 권한이없는 유형을 확장하는 기능이 포함 (소급-모델링 retroactive modeling)
 - 예) Int, String, Double 등 애플이 미리 만들어 놓은 타입에 확장도 가능
 ===================================================================================**/


/*:
 ---
 * 확장 문법
 ---
 */
// 기존 타입

class SomeType {
    
}


// 확장

extension SomeType {      // 기존의 타입에 extension 이라는 키워드를 사용해서 확장하고, 새로운 기능을 정의
    // 새로운 기능을 추가 가능(메서드 형태만 가능) ⭐️
    
}



// 기존 유형에 새 기능을 추가하기 위해 확장을 정의하면
// 확장이 정의되기 전에 생성된 경우에도 기존 인스턴스에서 새 기능을 사용 가능함

// 즉 코드의 순서와 상관 없다는 것임
/*:
 ---
 * 예시를 통한 확장의 이해
 ---
 */
class Person {
    var id = 0
    var name = "이름"
    var email = "1234@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}


class Student: Person {
    var studentId = 1
    
    override func walk() {
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}


extension Student {  // 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️ (@objc 붙이면 가능)
    //@objc func play() {
    func play() {
        print("학생이 논다.")
    }
}


class Undergraduate: Student {
    var major = "전공"
    
    override func walk() {
        print("대학생이 걷는다.")
    }
    
    override func study() {
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티한다.")
    }
    
    // func play() // 상속은 결국에 상위 클래스에 있는 멤버를 자동으로 가져오게 되어있음 그래서 Play라는 메서드도 자동으로 가져오는 것임
    
//    override func play() {     // 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️
//        print("대학생이 논다.")
//    }
    // 메모리상 [수평 확장]
    // 확장은 본질적으로 기존의 메서드 테이블이외에 따로 메서드를 추가하는 것(Direct Dispatch)
    // 상속이 되긴 하지만 그냥 가져오는 것임 : Swift에 특징이고 위에서 말한것 처럼
    // 굳이 재정의를 하자면 (@objc 붙이면 가능)
    // Objective C 약자임 메서드를 Objective C의 구현 방식으로 바꿔 주는 것임 Objective C 에서는 확장하고 재정의 가능 하도록
    // 구현 되어 있음 Objective C 에서는 메서드의 테이블이 배열로 구현 되어 있지 않음
}




//extension Undergraduate {
//    override func play() {
//        print("대학생이 논다.")
//    }
//}


/*:
 ---
 * 확장의 장점
 ---
 */
/*
 Int 애플에서 구조체로 복잡하게 구현 해놨음 애플이 이미 다 구현 했기 때문에 이 자체를 변형해서 사용 할 수 가 없음
 그 유일한 방법은 확장을 해서 사용하는 것임
 */
extension Int {
    var squared: Int {
        return self * self
    }
}

// 5,3,7 이거 자체가 지금 인스턴스 인것임
5.squared
3.squared
7.squared

// 이런걸 소급 모델링이라고 함
/*:
 ---
 * 확장 가능 멤버의 종류
 ---
 */
//:> 확장에서는 메서드형태만 정의 가능
/**==========================================================================================
 - 클래스, 구조체, (열거형) 확장가능 멤버
 
 - (원본 형식이 붕어빵틀 역할을 하기 때문에), 저장속성은 정의할 수 없음
 
 
 - 1) (타입) 계산 속성, (인스턴스) 계산 속성
 - 2) (타입) 메서드, (인스턴스) 메서드
 - 3) 새로운 생성자  (⭐️ 다만, 클래스의 경우 편의생성자만 추가 가능 / 지정생성자 및 소멸자는 반드시 본체에 구현)
        : 즉 확장에 개념에서는 지정생성자, 소멸자를 확장 할 수가 없는 것임 구조체나, 열거형은 원래 편의 생성자가 없기 때문에 약간 예외적 규정이 있음
 - 4) 서브스크립트
 - 5) 새로운 중첩 타입 정의 및 사용
 - 6) 프로토콜 채택 및 프로토콜 관련 메서드
 
 
 - 프로토콜에 대한 확장도 가능(자세한 내용은 프로토콜에서 다룰 예정)
 ============================================================================================**/


// 결론 메서드는 확장이 가능 저장 속성과 같은 메모리 구조를 차지하는게 아니기 때문에 
//:> 지정생성자는 본체에서 인스턴스를 찍어내는 중요역할을 하므로 ➞ 지정생성자는 확장에서 구현하지 못함




//Copyright (c) 2021 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
