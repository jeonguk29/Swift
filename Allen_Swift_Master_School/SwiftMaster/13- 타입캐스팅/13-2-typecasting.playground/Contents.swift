import UIKit


/*:
 ## 타입 캐스팅
* 인스턴스 타입을 검사 - is 연산자 / 클래스 계층 상의 타입 변환 - as 연산자
---
*/
//:> 상속: 기본적으로 데이터(저장 속성)를 추가하는 관점에서 생각

class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
}


class Student: Person {
    // id
    // name
    // email
    var studentId = 1
}


class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    var major = "전공"
}



let person1 = Person()
person1.id
person1.name
person1.email



let student1 = Student()
student1.id
student1.name
student1.email
student1.studentId // 추가적으로



let undergraduate1 = Undergraduate()
undergraduate1.id
undergraduate1.name
undergraduate1.email
undergraduate1.studentId
undergraduate1.major    //  추가적으로




/*:
---
* 인스턴스 타입의 (메모리구조에 대한) 힌트를 변경하는 - as 연산자 (type cast operator)
---
*/
//:> as 연산자
/**===================================================================
 - 타입캐스팅 / 타입캐스팅 연산자 (이항 연산자)
 (1) Upcasting (업캐스팅)
 - 인스턴스 as 타입
 - 하위클래스의 메모리구조로 저장된 인스턴스를 상위클래스 타입으로 인식

 (2) Downcasting (다운캐스팅) (실패가능성이 있음)
 - 인스턴스 as? 타입  / 인스턴스 as! 타입
   ▶︎ as? 연산자
    - 참이면 반환타입은 Optional타입
    - 실패시 nil 반환
   ▶︎ as! 연산자
    - 참이면 반화타입은 Optional타입의 값을 강제 언래핑한 타입
    - 실패시 런타임 오류
 
 [타입캐스팅의 의미]
 - 인스턴스 사용시에 어떤 타입으로 사용할지(속성/메서드) 메모리구조에 대한 힌트를 변경하는 것
 - 메모리의 값을 수정하는 것이 아님
 - (단순히 해당 타입의 인스턴스인 것처럼 취급하려는 목적)
======================================================================**/


let person2: Person = Undergraduate() // 붕어빵을 찍을때는 5개의 맴버를 가진 붕어 빵을 찍어냈지만 담을때는 Person으로 담음
person2.id
person2.name
person2.email
//person2.studentId    // Value of type 'Person' has no member 'studentId'
//person2.major          // Value of type 'Person' has no member 'major'



let person: Person = Person() // 이렇게 찍어 버리면 메모리 자체가 3개 찍히기 때문에 다운캐스팅 불가
person.id
person.name
person.email
//person.studentId    // Value of type 'Person' has no member 'studentId'
//person.major          // Value of type 'Person' has no member 'major'



/**=========================
 [Undergraduate인스턴스]
 - id: 0
 - name: "이름"
 - email: "abc@gmail.com"
 - studentId: 0
 - major: "전공"
 ==========================**/

// 그런데, 왜 studentId 와 major 속성에는 접근이 되지 않을까? ⭐️

// person2변수에는 Person타입이 들어있다고 인식되는 것임
// ===> 그래서 접근불가 ===> 접근하고 싶다면 메모리구조에 대한 힌트(타입)를 변경 필요



//:> as? / as! (다운캐스팅)

let ppp = person as? Undergraduate  // Undergraduate? 타입
// person 변수안에 있는 걸 Undergraduate 타입으로 변환해서 ppp에 담음 ppp 타입음 Undergraduate? 타입

if let ppp = person as? Undergraduate { // 옵셔널 형이라 이렇게 바인딩 해서 사용함
    ppp.name
    ppp.id
    ppp.email
    ppp.studentId
    ppp.major
}

// 이게 어떻게 되는거냐면
/* let person2: Person = Undergraduate() 위에서 이렇게 한 순간 부터 메모리에는 5개의 공간을 일단 찍는것임
 대신 타입이 Person으로 되어 있어서 보여지는 것만 3개를 보여지게 하는것임 실제로 5개를 가지고 있지만



if let pp = person as! Undergraduate { // 이렇게 쓰는걸 강제 다운 캐스팅이라고 함
    pp.name //pp 타입을 확인 해보면 Undergraduate? 타입 아니라 Undergraduate 타입임 강제로 풀었으니까
    pp.id
    pp.email
    pp.studentId
    pp.major
}

 대신 강제 다운 캐스팅은 안 벗겨지면 오류나고 꺼짐
 */

if let newPerson = person as? Undergraduate {   // if let 바인딩과 함께 사용 (옵셔널 언래핑)
    newPerson.major
    print(newPerson.major)
}

// 실제로 인스턴스의 접근 범위를 늘려주는 것 뿐임

let person3: Undergraduate = person as! Undergraduate // 이렇게 강제 다운 캐스팅 한걸 바로 담아서 사용
person3.major

/*
 다운캐스팅은 위에서 아래로 내려가기 때문에 실패 가능성이 있어서 as?, as! 이렇게 사용됨
 */



//:> as (업캐스팅)

let undergraduate2: Undergraduate = Undergraduate()
undergraduate2.id
undergraduate2.name
undergraduate2.studentId
undergraduate2.major
//undergraduate2.name = "길동"




let person4 = undergraduate2 as Person       // 항상 성공 (컴파일러가 항상 성공할 수 밖에 없다는 것을 알고 있음)
person4.id
person4.name
//person4.studentId
//person4.major


// 실질적으로 업케스팅을 할때 변수가 가리키는 클래스는 최종적으로 Undergraduate 임 그렇기 때문에
// 뒤에서 배우겠지만 같은 이름으로 재정의함 메서드가 있다면 Person 클래스에 메서드가 아닌 Undergraduate에서 재정의한 메서드가 실행됨
/*:
---
* 참고) as 연산자의 활용
---
*/
//:> Bridging (브릿징) ➞ 서로 호환되는 형식을 캐스팅해서 쉽게 사용하는 것
// 스위프트에서는 내부적으로 여전히 Objective-C의 프레임워크를 사용하는 것이 많기 때문에
// 서로 완전히 상호 호환이 가능하도록 설계해놓았음(completely interchangeable)
// 타입 캐스팅을 강제(as!)할 필요 없음


let str: String = "Hello"
let otherStr = str as NSString








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
