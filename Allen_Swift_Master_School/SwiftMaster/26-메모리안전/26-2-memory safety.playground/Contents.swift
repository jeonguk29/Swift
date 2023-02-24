import UIKit

/*:
 ## 구조체의 인스턴스에서의 메모리 안전
 * 메서드에서 self에 대한 접근
 ---
 */
func balance(_ x: inout Int, _ y: inout Int) { // 평균값 설정하는 함수
    let sum = x + y
    x = sum / 2
    y = sum - x
}



/**======================================================
 - 구조체 등의 메서드에서 self(동일한 인스턴스)에 접근하는 경우 접근 충돌
 - 값 타입은 속성 하나가 아닌, 인스턴스 전체에 대한 읽고/쓰기로 접근 ⭐️
 ========================================================**/


// 구조체 정의
struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    // 타입 속성
    static let maxHealth = 10
    
    // health값을 바꾸는 메서드 (self.health에 접근)
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

// 확장
extension Player {
    // 자신의 체력과, 동료의 체력을 공유해서 평균 설정
    mutating func shareHealth(with teammate: inout Player) {   // 메모리 장기적 접근
        balance(&teammate.health, &health)
    }
}


var mario = Player(name: "마리오", health: 10, energy: 10)
var luigi = Player(name: "루이지", health: 5, energy: 10)



// "마리오"와 "루이지"의 체력을 공유
mario.shareHealth(with: &luigi)   // 괜찮음


// "마리오"와 "마리오"의 체력을 공유하려면 에러 ⭐️
//mario.shareHealth(with: &mario)




/*:
 ---
 * 속성에 대한 접근 충돌의 예시
 ---
 */
// 튜플 만들기
var playerInformation = (health: 10, energy: 20)

// 튜플에 대한 동시접근 문제
//balance(&playerInformation.health, &playerInformation.energy)


/*
 😀 이렇게 튜플각 요소에 동시 접근할때도 메모리가 불안전 할 수 있다는것을 알아만 두면됨
 */


// 새로운 플레이어 생성
var yosi = Player(name: "요시", health: 10, energy: 10)

// 하나의 인스턴스(요시)의 체력과 에너지를 평균만들려고 하면?
//balance(&yosi.health, &yosi.energy)   // 에러 발생


// 전역이 아닌 "지역 변수"로 만들어서 접근하는 것은 괜찮음
func someFunction() {
    var yosi2 = Player(name: "요시2", health: 10, energy: 10)
    balance(&yosi2.health, &yosi2.energy)   //
}


/**=============================================
 컴파일러가 안전하다는 것을 판단하는 경우
 - 1) (계산 속성, 타입속성이 아닌) 인스턴스의 저장속성에만 접근하는 경우
 - 2) 구조체가 전역변수가 아닌, 지역변수로만 선언될때
 - 3) 구조체가 클로저에 의해 캡처되지 않았거나, non-escaping클로저만 캡처되었을때
===================================================**/

// 너무 이론적으로 접근할 필요 없이,
// 컴파일러는 때로 메모리 안전에 대한 증명(상호 영향이 없다는)이 가능해서
// 허락되는 경우가 있다 정도로 기억 ⭐️







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


