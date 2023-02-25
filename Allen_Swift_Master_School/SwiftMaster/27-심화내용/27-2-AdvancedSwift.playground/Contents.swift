import UIKit


/*:
 ## 2) Comparable 프로토콜
 * Comparable 프로토콜의 역할(값의 크기나 순서 비교, 정렬 가능하도록 하려면)
 ---
 */
/**=========================================================
 - Comparable 프로토콜의 요구사항은
 - static func < (lhs: Self, rhs: Self) -> Bool 메서드의 구현
 
 - 일반적으로 < 만 구현하면 <, <=, >= 연산자도 자동 구현
 - Comparable 프로토콜은 Equatable프로토콜을 상속하고 있음
   (필요한 경우, 비교연산자(==)도 구현해야함)
 
 - 스위프트에서 제공하는 기본 숫자 타입 및 String은 모두 다 채택을 하고 있음
   (Bool타입은 채택하지 않음)
 ===========================================================**/

/*
 😀 이전시간에는 == 만 구현하면 !=는 자동 구현해준다고 했음
 그와 마찮가지로 Comparable 프로토콜고 < 만구현하면 나머지 다 자동 구현해줌
 기본 타입에는 이러한 연산자가 다 구현 되어 있으니 역시 커스텀 타입에서 어떻게 구현해야하는지를 중점적으로 보자
 */


let num1: Int = 123
let num2: Int = 456

num1 < num2 // 결국 이러한 정수 비교가 가능한 이유는 내부적으로 Comparable 프로토콜을 채택하여 < 와 같은 메서드를 구현했기 때문임
num1 > num2

let str1: String = "Hello"
let str2: String = "안녕"

str1 < str2
str1 > str2




/**=============================================================
 [Int의 내부 구현]
   @frozen public struct Int : FixedWidthInteger, SignedInteger {
      ...
      public static func < (lhs: Int, rhs: Int) -> Bool
      ...
   }
================================================================**/





//:> 원칙: 값의 크기나 순서를 비교하려면, Comparable을 채택하고, < (less than)연산자 구현해야함
/**=========================================================================
 원칙) 구조체, 클래스의 모든 저장 속성(열거형은 원시값이 있는 경우)이 Comparable을 채택한
      경우라도, <(less than)연산자 직접 구현해야함
      (순서 정렬 방식에 대해서는 무조건 구체적인 구현이 필요하다는 논리)
 예외) 열거형의 경우, 원시값이 없다면(연관값이 있더라도) Comparable을 채택만 하면
      <(less than)연산자는 자동 제공
      (원시값을 도입하는 순간, 개발자가 직접 대응되는 값을 제공하므로 정렬방식도 구현해야한다는 논리)
============================================================================**/

/*:
 ---
 * 1) 열거형(Enum)의 경우
 ---
 */
// 원칙) 구조체, 클래스의 모든 저장 속성(열거형은 원시값이 있는 경우)이 Comparable을 채택한
//      경우라도, <(less than)연산자 직접 구현해야함 (순서 정렬 방식에 대해서는 무조건 구체적인 구현이 필요하다는 논리)
//      (원시값을 도입하는 순간, 개발자가 직접 대응되는 값을 제공하므로 정렬방식도 구현해야한다는 논리) ⭐️

enum Direction: Int {
    case east
    case west
    case south
    case north
}

extension Direction: Comparable {   //Type 'Direction' does not conform to protocol 'Comparable'
    static func < (lhs: Direction, rhs: Direction) -> Bool {
        return lhs.rawValue < rhs.rawValue      // 원시값을 기준으로 비교
    }
}


Direction.north < Direction.east    // false
Direction.north > Direction.east    // true





// 예외) 열거형의 경우, 원시값이 없다면(연관값이 있더라도) Comparable을 채택만 하면
//     <(less than)연산자는 자동 제공
//     (원시값을 도입하는 순간, 개발자가 직접 대응되는 값을 제공하므로 정렬방식도 구현해야한다는 논리) ⭐️


enum SuperComputer: Comparable {
    case cpu(core: Int, ghz: Double)
    case ram(Int)
    case hardDisk(gb: Int)
}


SuperComputer.cpu(core: 8, ghz: 3.5) < SuperComputer.cpu(core: 16, ghz: 3.5)    //  true
SuperComputer.cpu(core: 8, ghz: 3.5) > SuperComputer.cpu(core: 8, ghz: 3.5)     //  false



enum MyDirection: Comparable {
    case east
    case west
    case south
    case north
}


MyDirection.north < MyDirection.east    // false
MyDirection.north > MyDirection.east    // true




/*:
 ---
 * 2) 구조체(Struct)의 경우
 ---
 */
// 원칙) 구조체, 클래스의 모든 저장 속성(열거형은 원시값이 있는 경우)이 Comparable을 채택한
//     경우라도, <(less than)연산자 직접 구현해야함
//     (순서 정렬 방식에 대해서는 무조건 구체적인 구현이 필요하다는 논리)


struct Dog {
    var name: String
    var age: Int
}

extension Dog: Comparable {       // 이름순으로 갈것인지 / 나이순으로 갈 것인지 구현해야함

//    static func ==(lhs: Dog, rhs: Dog) -> Bool {                   // Equatable은 name, age의 저장 속성이 Equatable프로토콜을 구현하기에 자동제공
//        return lhs.name == rhs.name && lhs.age == rhs.age
//    }
    
    static func < (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.age < rhs.age
    }
}


let dog1: Dog = Dog(name: "초코", age: 10)
let dog2: Dog = Dog(name: "보리", age: 2)


dog1 < dog2
dog1 > dog2

/*
 😀 Comparable을 프로토콜의 경우 Equatable 프로토콜을 상속하고 있기 때문에
 == 메서드도 구현해줘야 하지만 구조체인 경우 저장속성이 모두 기본타입이(Equatable 채택이미 하고 있기 때문에)라면 자동으로 구현해줌
 당연히 ==를 직접 구현해도 됨   다시 돌아와서 < 만 구현해주면 됨
 */
/*:
 ---
 * 3) 클래스(Class)의 경우
 ---
 */
// 원칙) 구조체, 클래스의 모든 저장 속성(열거형은 원시값이 있는 경우)이 Comparable을 채택한
//     경우라도, <(less than)연산자 직접 구현해야함
//     (순서 정렬 방식에 대해서는 무조건 구체적인 구현이 필요하다는 논리)


class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}



extension Person: Comparable {
    
    // 클래스의 경우, ==연산자도 구현해야함
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    // 나이순으로 정렬하고자 함 ⭐️
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.age < rhs.age
    }
    
}



let person1: Person = Person(name: "홍길동", age: 20)
let person2: Person = Person(name: "임꺽정", age: 22)


person1 < person2
person1 > person2



/*
 클래스인 경우에는 == 메서드 또한 직접 구현을 해줘야함 클래스인 경우 자동으로 구현해주지 않음
 이전시간에도 말했듯이 클래스인경우 원래 비교 연산자 ===가 있기 때문에 ==연산자를 개발자에게 구현하도록 위임하기 때문임
 == 구현 안하면 Equatable의 요구사항을 구현하지 않았다고 오류남
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
