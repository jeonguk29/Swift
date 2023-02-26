import UIKit


/*:
 ## 키패스(keyPath)
 * keyPath의 개념에 대한 이해
 ---
 */
/*
 😀 요약 인스턴스의 속성에 접근하려는게 keyPath
 메서드 주소를 통해 메서드를 가리키기 위한 기술이 Selector 라는 기술임
 ketPath에서 dog1.name 이런식으로 접근하는 것은 dog1 라는 힙영역에 직접적 주소를 통한 접근임
 keyPath, Selector 둘다 간접적인 방법으로 접근 하기 위함
 keyPath : 문자열, 서브스크립트로 접근
 */
class Dog {
    var name: String
    init(name: String) {
        self.name = name
    }
}



let dog1 = Dog(name: "초코")

dog1.name

"dog1.name"    // 이런식으로 접근하면 안될까?



// 위의 코드에서 굳이 필요성을 느끼지 못할 수 있지만,

class School {
    var name: String
    var affiliate: SmallSchool
    
    init(name: String, affiliate: SmallSchool) {
        self.name = name
        self.affiliate = affiliate
    }
}


class SmallSchool {
    var classMember: Person
    init(classMember: Person) {
        self.classMember = classMember
    }
}


class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}



// 예전방식으로 구현하려고 한다면========
//class Person: NSObject {
//    @objc var name: String
//    init(name: String) {
//        self.name = name
//    }
//}
// ==============================




let person1 = Person(name: "홍길동")
let smallSchool1 = SmallSchool(classMember: person1)
let school1 = School(name: "슈퍼고", affiliate: smallSchool1)



// 만약에 접근하기위해, 써야하는 코드가 늘어난다면...

let gildogsName = school1.affiliate.classMember.name // 직접 접근



/*:
 ---
 * 결론 - Swift5의 방식 (Swift5 - keyPath 표현식)
 ---
 */
// 스위프트5의 방식

let namePath = \School.affiliate.classMember.name      // 미리 경로를 지정 (keyPath)

school1[keyPath: namePath]     // 딕셔너리방식(서브스크립트)로 접근

//😀 정리 keyPath는 경로를 정해 놓고 간접적으로 접근할 수 있는 기술임
/*
 왜 이렇게 바꾸느냐 gildogsName = 임꺽정 이런식으로 바꿀때 알림을 받고 싶어서 그러는 건데
 나중에 배우겠지만 이러한 기술 이름을 키벨류 옵저빙이라고 하고 이 기술의 근간이 되는게 keyPath 표현식임
 
 let namePath: ReferenceWritableKeyPath<School, String>
 참조타입이고 쓸수 있는 키패스이다 School이라는 타입이고 끝에 .name 이 문자열이라 제네릭으로 이렇게 자동으로 만들어 준것임
 */

let namePath2 = \School.affiliate.classMember
let newNamePath = namePath2.appending(path: \.name) // 이렇게 경로를 추가하는 함수도 있음
school1[keyPath: newNamePath]

/**================================================================================
 keyPath 타입 (외울 필요 없음)
 - AnyKeyPath                             : 어떤 속성인지 특정되지 않음(보통, 함수 파라미터형식으로만 사용)
 - PartialKeyPath<Root>                   : 타입에 대한 키패스(예를 들어 배열 같은 것으로 묶을때 사용)
 - KeyPath<Root, Value>                   : 타입과 (읽기)속성에 대한 키패스(구조체)
 - WritableKeyPath<Root, Value>           : 타입과 읽기/쓰기 가능한 속성에 대한 키패스(구조체)
 - ReferenceWritableKeyPath<Root, Value>  : 클래스의 타입과 읽기/쓰기 가능한 속성에 대한 키패스
===================================================================================**/

/*:
 ---
 * 예전 버전, 그리고 Objective-C의 방식 - #keyPath(타입.속성)방식
 ---
 */
/**==============================================
 - NSObject클래스를 상속해야함(구조체 지원 안함)
 - NSObject에 value(forKey:)메서드가 구현이 되어있기 때문
 - 속성에도 @objc를 붙여야함
 
 - 사용시, 구체적타입으로 다시 타입캐스팅해서 사용해야함
================================================**/



//let person2 = Person(name: "임꺽정")
//person2.name
//
//
//let gjName = person2.value(forKey: "name") as? String // 예전에는 문자열을 통해 접근하려고 했었음
//let gjName2 = person2.value(forKeyPath: #keyPath(Person.name)) as? String
            // 개발자가 자꾸 문자열 오타를 내서 아래와 같은 형태로 진화 이후에 우리가 위에서 배운 버전까지 진화 된것임
//
//
//let path = #keyPath(Person.name)
//let gjName3 = person2.value(forKeyPath: path) as? String




/*
 😀 정리 키패스는 속성에 접근하기 위한 기술이다 (간접적으로)  Objective-C에서 부터 발전된 기능이고
 프레임워크 내부에는  Objective-C 기술로 돌아가는 것들이 있다
 속성 관찰하고 싶은 기술들이 있는데 키패스는 라는 기술이 있음 
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
