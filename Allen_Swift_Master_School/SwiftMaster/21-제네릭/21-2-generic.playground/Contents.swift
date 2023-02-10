import UIKit

/*:
 ## 제네릭 타입의 정의
 * 제네릭(Generics) 구조체 / 클래스 / (열거형)
 ---
 */
/**====================================================================
 - 클래스, 구조체, 열거형의 타입이름 뒤에 타입 파라미터<T>를 추가하면, 제네릭 타입으로 선언됨
 - 타입 파라미터는 타입(형식) 이름뒤에 선언, 타입 제약 문법도 동일함  GridPoint<T: Equatable>

 - 속성의 자료형, 메서드의 파라미터형식, 리턴형을 타입 파라미터로 대체 가능
 ======================================================================**/

// 즉 이러한 커스텀 타입도 제네릭 타입으로 만들 수 있다는 것임

// 구조체로 제네릭의 정의하기
// 클래스, 구조체를 정의하는 데, 안의 멤버 변수들은 여러가지 타입을 가질 수 있는 가능성이 있을 것 같다면?


struct Member {
    var members: [String] = []      // 이렇게 만들면 해당 구조체는 문자열 배열 속성만 가질 수 있음
}



struct GenericMember<T> {   // 이렇게 구조체 이름 옆에 플레이스 홀더를 명시해주고
    var members: [T] = []       // 이와 같이 만들면 이 구조체는 어떠한 타입의 배열속성을 찍을 수가 있음
}


// 구조체의 멤버와이즈 이니셜라이즈로 배열 속성을 초기화
var member1 = GenericMember(members: ["Jobs", "Cook", "Musk"])
// member1 옵션키 누르고 확인해보면 GenericMember<String>임 그래서
// member1 = GenericMember(members: [1, 2, 3]) 다시 이런 붕어빵을 담을 수는 없음
// 생성자로 찍어낼때 메모리 구조가 결정 되는 것임

var member2 = GenericMember(members: [1, 2, 3])




// 클래스로 제네릭의 정의하기

class GridPoint<A> {
    var x: A
    var y: A
    
    init(x: A, y: A){
        self.x = x
        self.y = y
    }
}


let aPoint = GridPoint(x: 10, y: 20)
let bPoint = GridPoint(x: 10.4, y: 20.5)




// 열거형에서 연관값을 가질때 제네릭으로 정의가능
// (어짜피 케이스는 자체가 선택항목 중에 하나일뿐(특별타입)이고, 그것을 타입으로 정의할 일은 없음)

enum Pet<T> {
    case dog
    case cat
    case etc(T)
}



let animal = Pet.etc("고슴도치")

let animal2 = Pet.etc(30)

// 이런식으로 사용하면 코드의 유연성이 늘어남


/*:
 ---
 * 제네릭(Generics) 구조체의 확장
 ---
 */
// 정의

struct Coordinates<T> {
    var x: T
    var y: T
}



// 제네릭을 Extension(확장)에도 적용할 수 있다. (확장 대상을 제한하는 것도 가능은 함)

extension Coordinates {     // Coordinates<T> (X)   :   구조체 본체에서만 플레이스 홀더를 정의할 수 있고 확장시 사용만 가능
    
    // 튜플로 리턴하는 메서드
    func getPlace() -> (T, T) { // 구조체 만들때 제네릭 사용했다면 확장시 제네릭 타입 가능
        return (x, y)
    }
}


let place = Coordinates(x: 5, y: 5)
print(place.getPlace()) // 확장에서 정의한 메서드 실행



// where절 추가도 가능
// Int타입에만 적용되는 확장과 getIntArray() 메서드

extension Coordinates where T == Int {     // Coordinates<T> (X)
    
    // 튜플로 리턴하는 메서드
    func getIntArray() -> [T] {
        return [x, y]
    }
}


let place2 = Coordinates(x: 3, y: 5)
place2.getIntArray()        // 정수형 일때만 이 메서드가 구현이 되는 것임


// 아래와 같이 더블형으로 초기화를 했다면 T자체를 더블형으로 사용하는 것이기 때문에 확장이 안됨

//let place3 = Coordinates(x: 3.5, y: 2.5)
//place3.getIntArray()      // 이 메서드가 아에 없음



/*:
 ---
 * 타입 제약(Type Constraint)
 ---
 */
/**==================================================================
 - 제네릭에서 타입을 제약할수 있음
 - 타입 매개 변수 이름 뒤에 콜론으로 "프로토콜" 제약 조건 또는 "단일 클래스"를 배치 가능
 - (1) 프로토콜 제약 <T: Equatable>
 - (2) 클래스 제약 <T: SomeClass>
====================================================================**/



// Equatable 프로토콜을 채택한 타입만 해당 함수에서 사용 가능 하다는 제약

// Equatable 프로토콜은 == 이 가능한 타입을 말함 7 == 6 (결과 bool)정수형은 가능 함
func findIndex<T: Equatable>(item: T, array:[T]) -> Int? {     // <T: Equatable>
    for (index, value) in array.enumerated() {
        if item == value {  // 밸류값과 같은 배열의 인덱스 리턴함
            return index
        }
    }
    return nil
}


let aNumber = 5
let someArray = [3, 4, 5, 6, 7] // 5랑 같은 벨류가 있는 인덱스는 2임

if let index = findIndex(item: aNumber, array: someArray) { // 옵셔널로 구현해서 바인딩 하고 출력되게 구현했음
    print("밸류값과 같은 배열의 인덱스: \(index)")
}

/*
     == 이게 되려면 실제로 이 == 메서드가 구현이 되어 있어야 하는 것임 그렇기 때문에 타입 제약을 하고 있는 것임
*/


// 클래스 제약의 예시


class Person {} // 빈 붕어빵 틀
class Student: Person {}    // 빈 부어빵 틀 상속

let person = Person()
let student = Student()



// 특정 클래스와 상속관계에 내에 있는 클래스만 타입으로 사용할 수 있다는 제약  (구조체, 열거형은 사용 못함)
// (해당 타입을 상속한 클래스는 가능)

func personClassOnly<T: Person>(array: [T]) {
    // 함수의 내용 정의
}


personClassOnly(array: [person, person])
personClassOnly(array: [student, student])

//personClassOnly(array: [Person(), Student()])



/*:
 ---
 * 반대로 구체/특정화(specialization) 함수구현도 가능
 ---
 */
/**=================================================================================
 - 항상 제네릭을 적용시킨 함수를 실행하게만 하면, 또다른 불편함이 생기지 않을까?
 - (제네릭 함수가 존재하더라도) 동일한 함수이름에 구체적인 타입을 명시하면, 해당 구체적인 타입의 함수가 실행됨
 ===================================================================================**/


// 문자열의 경우, 대소문자를 무시하고 비교하고 싶어서 아래와 같이 구현 가능 ⭐️
// 위의 findIndex<T: Equatable>(item: T, array:[T]) -> Int? 와 완전 동일

func findIndex(item: String, array:[String]) -> Int? {
    for (index, value) in array.enumerated() {
        if item.caseInsensitiveCompare(value) == .orderedSame {
            // 이렇게 만든 이유는 문자열 파트에서 다루겠지만 데소문자가 달라도 같다고 비교하고 싶기 때문에 따로 구체적 함수를 만든 것임
            return index
        }
    }
    return nil
}



let aString = "jobs"
let someStringArray = ["Jobs", "Musk"]

// findIndex(item: aString, array: someStringArray) 구체적으로 타입명시한 함수에 문자열을 넣으면
// 위에 제네릭으로 만든 함수가 호출 되는게 아니고 문자열로 구체적 정의한 함수가 호출 됨
if let index2 = findIndex(item: aString, array: someStringArray) {
    print("문자열의 비교:", index2)
}


/*
 정리 항상 굳이 제네릭이 적용되게 할 필요는 없다 똑같은 이름으로 구체적인 타입을 명시하면, 해당 구체적인 타입의 함수를 실행시킬수 있다.
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
