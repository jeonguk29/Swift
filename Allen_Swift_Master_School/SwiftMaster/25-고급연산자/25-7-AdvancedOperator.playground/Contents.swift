import UIKit

/*:
 ## 사용자 정의 연산자
 * 스위프트가 제공하는 연산자 이외의 연산자 구현
 ---
 */
// ========================================================================
// 사용자 정의 연산자 기본 아래와 같이 Swift에서 지원하지 않는 연산자를 구현해서 사용할 수 있음
//var i = 0
//
//i = i + 1
//
//// 후치 연산자 정의
//postfix operator ++  // 그럴때는 미리 위에 정의를 해줘야함 이 연산자를 사용하겠다고
//
//extension Int {
//    static postfix func ++(number: inout Int){
//        number = number + 1
//    }
//}
//
//i++ // 후치 연산자 사용
//
//
//// 전치 연산자 정의
//prefix operator ++  // 그럴때는 미리 위에 정의를 해줘야함 이 연산자를 사용하겠다고
//
//extension Int {
//    static prefix func ++(number: inout Int){
//        number = number + 1
//    }
//}
//
//var a = 0
//++a // 후치 연산자 사용



// 조금 더 깊게 연산자에 대해 이해해보기
// (연산자도 사실은 내부적으로 다 구현이 되어있는 타입 메서드임)


// 앞 강의 (연산자 메서드) 예시 =========================================

struct Vector2D {
    var x = 0.0, y = 0.0
}


extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}


extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// ================================================================

//:> infix(중위) 연산자의 경우, 연산자의 "우선 순위 그룹"을 지정해야함 (우선 순위, 결합성)
// 중위연산자가 아닌 경우는 지정할 필요없음


/**======================================================
 - 1) 우선순위 그룹의 선언 (우선순위, 결합성 설정)
========================================================**/

precedencegroup MyPrecedence {
    higherThan: AdditionPrecedence  // 더하기 우선순위 그룹보다 높다
    lowerThan: MultiplicationPrecedence // 곱하기 우선순위 그룹보다 낮다
    associativity: left                   // 결합성 ===> left / right / none
}



/**======================================================
 - 2) (전역의 범위에서) 정의하려는 연산자를 선언하고, 우선순위 그룹을 지정
 - 단항 ==> 전치(prefix), 후치(postfix) / 이항 ==> infix
   키워드를 앞에 붙여야 함
 ========================================================**/


infix operator +-: MyPrecedence // 이 연산자 사용하겠다 전역선언
/*
😀 infix operator +- 이렇게만 해도 괜찮지만
 2 + 3 * 5 같은경우 뭐가 우선인줄 우리는 알고 있음 하지만 Swift에 없는 연산자를 만드는 거라
 이런 우선순위를 지정해줘야함
 */


// "우선 순위와 결합성"을 지정은 새로운 우선순위 그룹을 선언하거나, 이미 존재하는 우선 순위 그룹을 사용하는 것도 가능
// 우선순위 그룹을 지정하지 않으면 "DefaultPrecedence"라는 기본 그룹에 속하게 됨
// (삼항연산자보다 한단계 높은 우선순위가 되며, 결합성은 none설정되어 다른 연산자와 결합 사용은 불가능)



/**======================================================
 - 3) 연산자의 실제 정의
 - 해당 연산자를 구현하려는 타입에서 타입메서드로 연산자 내용을 직접 구현
 ========================================================**/

extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}



// 커스텀 연산자의 사용

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector

print(plusMinusVector)                             // Vector2D(x: 4.0, y: -2.0)




// 우선순위와 결합성의 선언
// https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations


/*:
 ---
 * 중위연산자가 아닌 경우의 예시
 ---
 */
// 1) 연산자의 선언

prefix operator +++


// 2) 연산자의 실제 정의

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector   // 복합할당 연산자는 이미 구현되어있기 때문에 사용 가능
        return vector
    }
}


// 커스텀 연산자의 사용

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 의 값은 이제 (2.0, 8.0) 입니다.
// afterDoubling 도 값이 (2.0, 8.0) 입니다.





// 조금 더 쉬운 예시 =======================================

// 1) 연산자 (위치) 선언

prefix operator ++


// 2) 연산자의 실제 정의

extension Int {
    static prefix func ++(number: inout Int) {
        number += 1
    }
}


var a = 0
++a   // +1
++a   // +1
++a   // +1
print(a)







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
