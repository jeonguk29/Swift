import UIKit

/*:
 ## 연산자 메서드
 * 연산자 메서드? 커스텀 타입에도 메서드의 형태로 연산자(+, -, == 등)를 구현 가능
 ---
 */
// 조금 더 깊게 연산자에대해 이해해보기
// (연산자도 사실은 내부적으로 다 구현이 되어있는 타입 메서드임)

"Hello" + ", Swift!"     // "Hello, Swift!"
// 커멘드 누르고 + 들어가보면 String타입의 타입메서드 이름이 +임 근데 +() 이렇게 사용은 안함 내부적 처리에 의해

var a = ""
a += "!"


/**==================================================
 - String 구조체 내부에 타입 메서드로 정의되어 있음
 
 [문자열 더하기]
 static func + (lhs: String, rhs: String) -> String
 
 [문자열 복합할당 연산자]
 static func += (lhs: inout String, rhs: String)
 ==================================================**/

// inout은 파라미터 주소를 직접 넣었다 뺏다 하는 것임
// infix operator +: 우선순위 그룹
// + 함수를 위처럼 중위연산자라고 내부 적으로 처리해서 () 형태로 사용하지 않는 것임

//:> 연산자: 타입.함수이름(파라미터: 타입) 형태로 실행하지 않는.. 특별한 형태의 타입 메서드



//String.+(lhs: "Hello", rhs: ", Swift!")


/*:
 ---
 * 1) 연산자 메서드의 구현
 ---
 */
/*
 생각보다 앱만들때 연산자 메서드 구현해야 할 경우 많음
 */

// 스위프트 공식 문서의 예제

struct Vector2D {
    var x = 0.0
    var y = 0.0
}


// 1) 산술 더하기 연산자의 구현 (infix 연산자)

//infix operator + : AdditionPrecedence       // 연산자 선언

extension Vector2D {
    static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        // 들어오는 각 구조체의 좌표 값을 더한걸 각각의 생성자 매개변수로 넣어줌
        return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    // 왜 타입메서드로 만드냐 서로다른 인스턴스를 더해줘야하기 때문임 한차원 높은 공용적 영역에서 처리해야함
    // 이항 연산자인 경우는  static infix func + : infix 라는 키워드 필요함 근데 가장 많이 사용해서 생략가능
}


let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)

let combinedVector = vector + anotherVector
//print(combinedVector)

/*
 😀 우리가 구조체로 만든 인스턴스를 더하고 싶은데 더히기 연산자 구현이 되어있지 않아서 오류남 그래서 확장에서 구현시킴
 */


// 2) 단항 prefix 연산자의 구현 (전치연산자)

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}


let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
//print(negative)
let alsoPositive = -negative
//print(alsoPositive)




// 3) 복합할당 연산자의 구현

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right // 위에서 + 메서드 구현해서 여기서 사용가능함
    }
}



/*:
 ---
 * 2) 비교연산자 - 연산자 메서드(==, !=)의 직접적인 구현
 ---
 */

"swift" == "Swift"   // false
"swift" == "swift"   // true
"swift" != "swift"   // false

"swift" < "Swift"    // false
"swift" >= "Swift"   // true




/**==================================================
 - String 구조체 내부에 타입 메서드로 정의되어 있음
 
 [Equatable 동일성비교에 관한 프로토콜]
 static func == (lhs: String, rhs: String) -> Bool
 static func != (lhs: String, rhs: String) -> Bool
 
 [Comparable 크기, 순서비교에 관한 프로토콜]
 static func < (lhs: String, rhs: String) -> Bool
 static func > (lhs: String, rhs: String) -> Bool
 static func <= (lhs: String, rhs: String) -> Bool
 static func >= (lhs: String, rhs: String) -> Bool
 ==================================================**/

// Comparable 프로토콜을 채택한 타입에서는 모두 위와 같은 메서드가 구현되어 있음
// (Comparable프로토콜은 Equatable프로토콜을 상속 - 동일성 비교가 가능해야, 크기도 비교 가능)

/*
 Equatable 채택시 ==, != 메서드 구현해줘야함
 Comparable 채택시 <, >, <=, >= 메서드 구현필요 (사실상 위에 까지 총 6개)
 */


let vector1 = Vector2D(x: 1.0, y: 2.0)
let vector2 = Vector2D(x: 2.0, y: 3.0)

vector1 == vector2


// "비교 연산자 메서드"를 구현하는 것이 왜 필요할까?
// 같은지 비교를 할 수 없음(비교할 수 있는 연산자 메서드가 구현되어 있지 않기 때문)
// ===> 컴파일러는 어떤 규칙으로 두 인스턴스를 비교해야할지 모름


/*
    😀 즉 구조체 인스턴스를 비교하기 위해서는 Equatable 프로토콜을 채택하여
 !=, == 메서드 구현 필요함
 */
//:> Equatable 프로토콜을 채택해야함
/**========================================================================
 - Equatable 프로토콜을 채택하기만 하면
   (이 경우) 컴파일러가 연산자 메서드 구현 내용 자동 추가해줌
   1) 열거형 - 연관값이 있으면서, 모든 연관값이 Equatable 프로토콜을 준수하는 경우
   2) 구조체 - '저장속성'만 가지며, 저장속성의 타입이 Equatable 프로토콜을 준수하는 경우
 
 - == (Equal to operator)를 구현하면 != (Not equal to operator) 자동구현
   (두 연산자를 모두 구현할 필요 없음)
 ==========================================================================**/


// 연산자 메서드를 구현하면 비교가 가능해짐
// Equatable 프로토콜을 채택 후, 구현


/*
 😀
 extension Vector2D: Equatable {
    // 이렇게만 사실 채택만 해도 우리가 할일이 끝남 우리가 비교할 구조체가 저장속성만 가지고 있고
    // 그 저장 속성 타입이 더블형임 ex var x = 0.0 , var y = 0.0 Swift에 기본 타입들은 기본적으로 Equatable 프로토콜을 준수 하고 있고 내부적으로 다 처리 되어 있기 때문에 컴파일러가 우리가 구현할 !=, == 메서드 자동 구현 해줌
 }
 */

extension Vector2D: Equatable {
    
    // 직접구현
    static func ==(lhs: Vector2D, rhs: Vector2D) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
    
//    static func !=(lhs: Vector2D, rhs: Vector2D) -> Bool {
//        return (lhs.x != rhs.x) || (lhs.y != rhs.y)
//    }
}


vector1 == vector2
vector1 != vector2


let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)

if twoThree == anotherTwoThree {
    print("두 개의 벡터값은 동일함.")
}



//:>(참고) 열거형의 경우, 연관값이 없다면 원칙적으로 동일성 비교 가능
/**===========================================================
 *(연관값이 전혀 없는) 열거형의 경우 굳이 Equatable프로토콜을 채택하지 않아도,
  연산자(==) 메서드 자동 채택/구현
 =============================================================**/

enum Weekday {
    case mon
    case tues
}

Weekday.mon == Weekday.tues
/*
 열거형이라는게 한정된 사례에서 타입을 정의를 하는 것임
 이게 같은지 다른지 까지는 Swift에서 판별 가능함
 */

enum Weekday2 {
    case mon(String)
    case tues(String)
}

// Weekday2.mon("하하") == Weekday2.tues("히히")

/*
 이거를 같다고 할지 다르다고 할지 연관값이 있을때는 정의를 해줘야하는 것임
 
 enum Weekday2:Equatable {
     case mon(String)
     case tues(String)
 }

 Weekday2.mon("하하") == Weekday2.mon("하하") true나옴
 */


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
