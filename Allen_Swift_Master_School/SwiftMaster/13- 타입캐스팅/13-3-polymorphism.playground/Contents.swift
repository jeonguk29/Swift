import UIKit


/*:
 ## 타입과 다형성(Polymorphism)
* 상속관계에서 인스턴스의 다형성에 대한 이해
---
*/

class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}


class Student: Person { //상위 클래스에 속성 값이 다 있기 때문에 생성자를 만들 필요는 없음
    // id
    // name
    // email
    var studentId = 1
    
    override func walk() {         // 재정의 메서드. walk() - 1
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}



class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    var major = "전공"
    
    override func walk() {       // 재정의 메서드. walk() - 2
        print("대학생이 걷는다.")
    }
    
    override func study() {      // 재정의 메서드. study() - 1
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티를 한다.")
    }
}



let person1 = Person()
person1.walk()



//let student1 = Student()
let student1: Person = Student()    // 이렇게 업캐스팅 한다고 하면 메모리공간을 가지긴 하지만 Person 해당하는 멤버만 접근 할 수 있음
student1.walk()     // 이렇게 하면 학생이 걷는다라고 나옴
//student1.study()



//let undergraduate1 = Undergraduate()
let undergraduate1: Person = Undergraduate()
undergraduate1.walk()   // 대학생이 걷는다 나옴  이게 바로 다형성과 관련된 내용임
//undergraduate1.study()
//undergraduate1.party()

/*
 우리가 let undergraduate1: Person = Undergraduate() 이렇게 한다고 하면
 스택 영역에 undergraduate1 라는 상수가 Person형이라고 인식만 하는 거고 실질 적으로 인스턴스를 찍을때는
 데이터 영역에 Undergraduate로 찍어서 힙영역에 인스턴스가 생기는 것임 그래서
 undergraduate1.walk() 코드를 실행하면 내부적으로 Undergraduate로 찍은 인스턴스에 접근해서
 데이터영역에 재정의한 walk 메서드를 가리키고 그 메서드는 코드영역에 대학생이 걷는다를 출력하게 되는것임
 이런 구조때문에 아무리 업캐스팅 한다고 하더라도 다른 형태에 메서드를 출력 한다는 것을 알아야함 그리고 이게 바로 다형성과 관련된 개념임
 */



/*:
---
* 다형성(Polymorphism) ⭐️ (여러가지 모양)
---
*/
/**================================================================
 [다형성(Polymorphism)]
 - 하나의 객체(인스턴스)가 여러가지의 타입의 형태로 표현될 수 있음을 의미.        (메모리 힙영역에 찍혀 있는 인스턴스가)
   (또는 하나의 타입으로 여러 종류의 객체를 여러가지 형태(모습)로 해석될 수 있는 성격)
 
 - 다형성이 구현되는 것은 "클래스의 상속"과 깊은 연관이 있음(향후 배울 프로토콜과도 연관)
===================================================================**/
// 다형성은 포괄적 개념이라 위에서 본 상속에서 여러가지 형태로 메서드를 실행 시킬수도 있는 것을 말함
// 이 개념을 포함하여 객체지향 언어의 4대 특징을 다 알아봄 캡상추다 : 캡슐화, 상속, 추상화, 다형성,


let people: [Person] = [Person(), Student(), Undergraduate()]


// 반복문
for person in people {
    person.walk() // 실행가는 3개가 모두 공통적으로 가지고 있는 속성이라
    // 각각의 클래스에 메서드테이블을 찾아가기 때문에 결과가 다른건 당연한것임 
    //person.study() 아에 보이지도 않음
}


// 한개씩
people[0].walk()     // Person 타입으로 인식 (Person 인스턴스)
people[1].walk()     // Person 타입으로 인식 (Student 인스턴스)
people[2].walk()     // Person 타입으로 인식 (Undergraduate 인스턴스)


//:> 상속관계에서 다형성은 메서드를 통해 발현
/**============================================================
 - 업캐스팅된 타입(Person) 형태의 메서드를 호출하더라도 실제 메모리에서 구현된
   "재정의된" 메서드(Undergraduate의 메서드 테이블)가 호출되어 실행 ⭐️
 
 - 타입의 저장 형태는 속성/메서드에 대한 접근가능 범위를 나타내는 것이고,
   다형성은 인스턴스에서 메모리의 실제 구현 내용에 대한 것임
   (메서드는 재정의 가능하고, 메서드 테이블을 통해 동작)
 =============================================================**/









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
