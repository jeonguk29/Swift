import UIKit

/*:
## 5) 멤버의 확장(중첩타입)
* 5. 중첩 타입(Nested Types)
---
*/
class Day {
    enum Weekday {
        case mon
        case tue
        case wed
    }
    
    var day: Weekday = .mon
}

var ddd: Day.Weekday = Day.Weekday.mon
// 타입 내부에 있는 타입 일반적으로 Weekday는 Day 클래스 내부에서만 쓰이는 열거형임
// 즉 타입 안에 타입을 정의 할 수 있음


// 클래스, 구조체 및 열거형에 새 중첩 유형을 추가 가능

// Int(정수형 타입)에 종류(Kind) ====> 중첩 열거형 추가해 보기

extension Int {
    
    enum Kind {       // 음수인지, 0인지, 양수인지
        case negative, zero, positive
    }
    
    var kind: Kind {    // 계산 속성으로 구현
        switch self {
        case 0:                   // 0인 경우
            return Kind.zero
        case let x where x > 0:   // 0보다 큰경우
            return Kind.positive
        default:                  // 나머지 (0보다 작은 경우)
            return Kind.negative
        }
    }
}

// 현재 예제는 클래스안에 중첩타입으로 열거형을 추가하고 계산 속성도 하나 추가 한 것임


let a = 1
a.kind       // 숫자 1의 (인스턴스) 계산속성을 호출 ====> 해당하는 열거형(Int.Kind타입)을 리턴
// 1.kind 위코드는 이거랑 동일함

let b = 0
b.kind

let c = -1
c.kind


Int.Kind.positive
Int.Kind.zero
Int.Kind.negative

// 이렇게 담아 사용도 가능함
let d: Int.Kind = Int.Kind.negative


//----------------즉 확장에서 중첩타입을 정의 할 수 있음


// 위의 확장을 통해서, 어떤 Int값에서도 중첩 열거형이 쓰일 수 있음

// 위의 확장을 활용한 ===> 함수 만들어보기

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}



// 함수 실행해보기

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])      // + + - 0 - 0 +



// 이런식으로 애플이 미리 만들어놓은 자료형 등에 중첩타입을 확장하여 활용이 가능함
// 클래스 안에 클래스 열거형 구조체 안에 열거형 등 응용 가능함





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
