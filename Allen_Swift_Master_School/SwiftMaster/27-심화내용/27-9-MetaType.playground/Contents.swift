import UIKit

/*:
 ## 메타타입(Metatype)
 * 메타타입의 개념에 대한 이해
 ---
 */
class Dog {
    static let species = "Dog"  // 타입저장 속성 선언 되어있음
    var name: String = ""
    var weight: Double = 0.0
}


       // ⬇︎ 붕어빵의 타입
let dog1: Dog = Dog()
               // ⬆︎ 붕어빵

dog1.name = "초코"
dog1.weight = 10.0



let dog2: Dog = Dog()
dog2.name = "보리"
dog2.weight = 15.0



//:> 메타 타입은 타입(인스턴스)(붕어빵틀의 메모리)의 타입임
      // ⬇︎ 붕어빵틀의 타입
let dog: Dog.Type = Dog.self
                    // ⬆︎ 붕어빵틀

let dogSelf: Dog.Type = type(of: dog1)    // 붕어빵틀
// type(of: dog1) == Dog.self


Dog.species     // "Dog"
Dog.self.species    // "Dog"

/*
 😀
 Dog.self 가 static let species = "Dog"  라는 값을 데이터 영역이 가지고 있는 실제 인스턴스임
 Dog.species 기존에 이렇게 사용하던것은 Dog.self.species   이렇게 사용해야하는 걸 축약한것임
 즉 데이터 영역에 붕어빵 틀에 저장 되어있는 타입 속성들을 사용할때 이렇게 접근 하는 것임
 */


class Person {
    static let species = "인간"
    var name: String = ""
}


// 인스턴스의 타입과 인스턴스
let person1: Person = Person()
person1.name = "홍길동"


// 인스턴스의 타입과 인스턴스
let person2: Person = Person()
person2.name = "임꺽정"



//:> 메타타입의 이해
// 붕어빵틀의 타입   // 붕어빵틀의 메모리
let pSelf1: Person.Type = Person.self
let pSelf2: Person.Type = type(of: person1)   // 타입의 타입 (붕어빵틀형식으로 메모리에 있어)

/*
 😀 Person.self 에는 species = "인간" 타입속성을 가진 틀을 말하고
 굳이 이걸 변수에 넣는다고 했을때 타입에 대한 선언을 Person.Type 이런식으로 하는 것만 할면 됨
 */

pSelf1.species  // "인간"
pSelf2.species  // "인간"
Person.species  // "인간"
Person.self.species // "인간"




var num1: Int = 5  // 붕어빵
var num2: Int = 7


// (타입자체의) 타입속성
Int.max
Int.self.max    // 데이터 형역의 타입인스턴스 (붕어빵 틀을 의미) 이걸 담을따 사용하는게 메타타입

Int.zero
Int.self.zero



var numberSelf: Int.Type = Int.self // 타입 인스턴스의 타입을 쓴다면 .Type  이렇게 쓴다 이걸 메타타입이라고 함




type(of: person1)
Person.self


/*:
 ---
 * 메타타입을 선언하는 방법
 ---
 */
/**======================
 [커스텀타입의 경우]
 - 클래스이름.Type
 - 구조체이름.Type
 - 열거형이름.Type

 [프로토콜의 경우]
 - 프로토콜이름.Protocol
========================**/




/*:
 ---
 * 메타타입을 사용하는 API
 ---
 */
/**=======================================
 - 1) 테이블뷰셀을 등록하는 경우에 메타타입을 사용
 =========================================**/

// tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)

func doSomething(a: Int){   // 함수를 선언할때는 직접적으로 타입에 대해 선언해야하고
    
}
doSomething(a: 5)   // 실행 시에는 직접적인 값을 줘야함

// <#T##cellClass: AnyClass?##AnyClass?#> 아래 주석에서 말하고 있지만 옵셔널 AnyClass는  AnyObject.Type 로 선언이 되어 있는 것임
// 즉 메타타입으로 선언 되어있으니까 실행시킬때 실제 인스턴스를 줘야하는 것임 ex MyCell.self    내가 만든 타입 인스턴스를 넣는 것임


/**=======================================
  - 2) JSONDecoder 객체를 사용해서 디코드메서드 사용시
 =========================================**/

// try? decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)

/*
 😀 저번에 사용했지만 위에 매개변수도 메타타입으로 선언 되어 있었던것임 <#T##type: Decodable.Protocol##Decodable.Protocol#> 을 채택한 인스턴스
 Moive.self 이런식으로 썻었음
 메타 타입을 요구하는 메서들은 구체적 인스턴스가 필요한 녀석들이 아님 타입 자체를 뭔가를 하겠다를 말하는 메서드들임
 
 즉 이렇게 타입자체를 요구하는 메서드들이 있는데 그게 어떤 문법인지 한번 알아본것임 타입인스턴스의 대한 타입을 표시한 것이라고 생각
 */


/**=========================================================
[AnyClass에 대한 이해]
 - typealias AnyClass = AnyObject.Type
 - https://developer.apple.com/documentation/swift/anyclass
============================================================**/






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
