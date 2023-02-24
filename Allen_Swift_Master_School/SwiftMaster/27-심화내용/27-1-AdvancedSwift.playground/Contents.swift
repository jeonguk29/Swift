import UIKit

/*:
 # Part27 - 심화 과정(Advanced Swift)
 */
/*:
 ## 주요 프로토콜
 * Equatable / Comparable / Hashable
 ---
 */
//:> 각 프로토콜의 역할을 큰그림으로 파악 ➡︎ 나머지는 굳이 외울 필요 없음(필요할때 찾아쓰기)
/**==========================================================
 - 1) Equatable : ==, != 비교 연산자 관련 프로토콜
 - 2) Comparable : < 연산자 관련 프로토콜 (>, <=, >=)
 - 3) Hashable : hash값을 갖게되어 값이 해셔블(값이 유일성을 갖게됨)해짐
 ============================================================**/




/*:
 ## 1) Equatable 프로토콜
 * Equatable 프로토콜의 역할 (동일성의 판단)
 ---
 */
/**=========================================================
 - Equatable 프로토콜의 요구사항은
 - static func == (lhs: Self, rhs: Self) -> Bool 메서드의 구현
 - 스위프트에서 제공하는 기본 타입은 모두다 채택을 하고 있음
 ===========================================================**/


let num1: Int = 123
let num2: Int = 456

num1 == num2    // 정수 비교할때도 사실  ==는 타입메서드 였음
num1 != num2

let str1: String = "Hello"
let str2: String = "안녕"

str1 == str2
str1 != str2



/*
 하지만 class, struct, enum 같은 개발자가 직접적으로 만들어내는 커스텀타입들은 == 연산자 즉 메서드가 구현 되어 있지 않을 수 있다는 것임
 
 */

/**=============================================================
 [Int의 내부 구현]
   @frozen public struct Int : FixedWidthInteger, SignedInteger {
      ...
      public static func == (lhs: Int, rhs: Int) -> Bool
      ...
   }
================================================================**/





//:> 원칙: 동일성을 비교(==)하려면, Equatable을 채택하면 ➡︎ 비교연산자(==)메서드 자동구현
/**=======================================================================
 원칙) 구조체, 열거형의 경우 Equatable 프로토콜 채택시 모든 저장 속성(열거형은 모든 연관값)이
      Equatable 프로토콜을 채택한 타입이라면 비교연산자 메서드 자동구현
 예외) 1) 클래스는 인스턴스 비교를 하는 항등연산자(===)가 존재하기 때문에 비교연산자(==)
         구현방식에 대해 개발자에게 위임 (클래스는 원칙적으로 동일성(==) 비교 불가)
      2) 열거형의 경우 연관값이 없다면 기본적으로 Equatable/Hashable하기 때문에
         Equatable 프로토콜을 채택하지 않아도 됨
==========================================================================**/

/*:
 ---
 * 1) 열거형(Enum)의 경우
 ---
 */
// 원칙) 구조체, 열거형의 경우 Equatable 프로토콜 채택시 모든 저장 속성(열거형은 모든 연관값)이
//      Equatable 프로토콜을 채택한 타입이라면 비교연산자 메서드 자동구현
//      (추가정보들이 Int, Double 등 이미 Equatable프로토콜을 채택해서, 구체적인 정보들까지 동일성 판별이 가능하기 때문)

enum SuperComputer: Equatable {
    case cpu(core: Int, ghz: Double)
    case ram(Int)
    case hardDisk(gb: Int)
}



SuperComputer.cpu(core: 8, ghz: 3.5) == SuperComputer.cpu(core: 16, ghz: 3.5)
SuperComputer.cpu(core: 8, ghz: 3.5) != SuperComputer.cpu(core: 8, ghz: 3.5)

/*
 😀 Equatable 프로토콜 채택하기만 해도 위코드는 내부적으로 == 타입메서드 구현 처리해줌
    아래 코드와는 그래도 좀 다르게 단순하게 구현 된것은 아니라서 최소한 Equatable 채택까지는 해줘야함
 */



// 예외-2) 연관값이 없다면(원시값 여부는 상관없음) Equatable 프로토콜을 채택하지 않아도 동일성 비교 가능
// ===> 기본적으로 추가정보가 없다면 같은지/다른지 동일성은 판별 가능하다는 논리 ⭐️


enum Direction {
    case east
    case west
    case south
    case north
}


Direction.north == Direction.east    // false
Direction.north != Direction.east    // true


/*
 😀 보면 위에 열거형 같은경우에는 : Equatable 프로토콜 채택하여 ==메서드 구현하지도 않았는데
 ==를 사용할 수 있음 이유는 : 이러한 최소한의 비교도 할 수없다면 개발자가 너무 불편해짐 열거형을 만들때마다
 Equatable 채택하고 타입메서드 구현한다이러면 개발자한테 너무너무 불편 할 수있다는 것임
 그래서 이러한 간단한 열거형 같은 경우는 애플이 알아서 자동으로 내부 구현을 해준다고 생각하면 됨
 */

/*:
 ---
 * 2) 구조체(Struct)의 경우
 ---
 */
// 원칙) 구조체, 열거형의 경우 Equatable 프로토콜 채택시 모든 저장 속성(열거형은 모든 연관값)이
//      Equatable 프로토콜을 채택한 타입이라면 비교연산자 메서드 자동구현
//     (저장속성이 Int, Double 등 이미 Equatable프로토콜을 채택해서, 동일성 판별이 가능하기 때문)


struct Dog {
    var name: String
    var age: Int
}

extension Dog: Equatable {}


// 이렇게 전체 구현할 필요 없음
//extension Dog: Equatable {
//    static func ==(lhs: Dog, rhs: Dog) -> Bool {
//        return lhs.name == rhs.name && lhs.age == rhs.age
//    }
//}


let dog1: Dog = Dog(name: "초코", age: 10)
let dog2: Dog = Dog(name: "보리", age: 2)


dog1 == dog2
dog1 != dog2

/*
 😀 이 단원에서 가장 중요한 부분 구조체인경우 같은지 다른지 비교할때는 최소한 Equatable 을 채택해줘야함
 앱만들때 이 구조체 비교를위해서 위 개념은 한번쯤 꼭 만나게 되는 개념임
 */
/*:
 ---
 * 3) 클래스(Class)의 경우
 ---
 */
// 예외-1) Equatable 프로토콜 채택시 클래스는 예외
//       클래스는 인스턴스 비교를 하는 항등연산자(===)가 존재하기 때문에 비교연산자(==) 구현방식에 대해
//       개발자에게 위임 (클래스는 원칙적으로 동일성(==) 비교 불가)


class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


// 비교하고 싶어서, Equatable 프로토콜 채택 ====> 클래스에서는 에러 발생 ===> 비교연산자(==)를 구현 직접구현해야함

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {  // 특별한 이유가 없다면 모든 속성에 대해, 비교 구현
        return lhs.name == rhs.name && lhs.age == rhs.age
        //return lhs.name == rhs.name     // 이름만 같아도 동일하다고 보려면 이렇게 구현
        //return lhs.age == lhs.age       // 나이만 같아도 동일하다고 보려면 이렇게 구현
    }
}



let person1: Person = Person(name: "홍길동", age: 20)
let person2: Person = Person(name: "임꺽정", age: 20)


person1 == person2
person1 != person2



/*
 😀 클레스의 인스턴스는 힙에저장됨 그렇기 때문에 주소 값을 비교하여 같은지 반환해주는 === 연산자가 이미 있기 때문에
 ==는 따로 직접 구현해줘야함  
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
