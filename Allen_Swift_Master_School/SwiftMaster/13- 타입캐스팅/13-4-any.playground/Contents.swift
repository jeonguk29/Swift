import UIKit


/*:
 ## Any와 AnyObject를 위한 타입 캐스팅
* Any와 AnyObject 타입
---
*/
/**===================================================================
 - 스위프트에서 제공하는 불특정한 타입을 다룰 수 있는 타입을 제공
 
 1) Any 타입
 - 기본 타입(Int, String, Bool, ...) 등 포함, 커스텀 클래스, 구조체, 열거형, 함수타입
   까지도 포함해서 어떤 타입의 인스턴스도 표현할 수 있는 타입 (옵셔널타입도 포함)
 
 2) AnyObject 타입
 - 어떤 클래스 타입의 인스턴스도 표현할 수 있는 타입
======================================================================**/



// 1) Any타입 ============================================

var some: Any = "Swift"
some = 10
some = 3.2



// 단점 ===> 저장된 타입의 메모리 구조를 알 수없기 때문에, 항상 타입캐스팅해서 사용해야함 ⭐️

var some2: Any = "Swift"
// some2.count 문자열을 넣는데도 불구하고 기존 문자열 타입에서 사용했던 타입 메서드가 사용이 안됨
// 왜냐면 some2은 Any 타입으로 인식 하고 있기 때문에 Any타입에는 count라는 메서드가 구현 되어 있지 않은 것임
// 그렇기 때문에 사용 불가 사용하고 싶다면 타입 캐스팅 해서 사용해야함
(some2 as! String).count // 혹은

var some3 = some2 as! String
some3.count

// Any 타입 일반적인 경우에 불편하기 때문에 잘 사용하지는 않음 타입 캐스팅을 해서 사용해야 하기 때문에

class Person {
    var name = "이름"
    var age = 10
}

class Superman {
    var name = "이름"
    var weight = 100
}


// Any타입의 장점: 모든 타입을 담을 수 있는 배열을 생성 가능            // (String) -> String
let array: [Any] = [5, "안녕", 3.5, Person(), Superman(), {(name: String) in return name}]
// 클래스 인스턴스, 클로저 다 들어 갈 수 있음

//array[1].count
(array[1] as! String).count





// 2) AnyObject타입 =======================================

// 클래스의 인스턴스만 담을수 있는 타입임 구조체 인스턴스도 담을수 없음 반드시 클래스 인스턴스만 가능
let objArray: [AnyObject] = [Person(), Superman(), NSString()]

//objArray[0].name
(objArray[0] as! Person).name // 이렇게 타입 캐스팅 후 사용해줘야함




// 아래는 공식 문서 내용임 이해해야함


// 타입캐스팅 + 분기처리

for (index, item) in array.enumerated() {
    // (0,  5)
    // (1, "안녕")
    // (2, 3.5)
    // ...
    
    switch item { // 여기는 Any 타입이 들어 갈 것임 우리가 기존에 값 비교 하는 형태랑 다르게 아래와 같이 이용됨
    case is Int:                                  // item is Int
        print("Index - \(index): 정수입니다.")
    case let num as Double:                       // let num = item as Double  (아이템이 더블로 바뀌면 num에다 담겠다)
        print("Index - \(index): 소수 \(num)입니다.")
    case is String:                               // item is String
        print("Index - \(index): 문자열입니다.")
    case let person as Person:                    // let person = item as Person
        print("Index - \(index): 사람입니다.")
        print("이름은 \(person.name)입니다.")
        print("나이는 \(person.age)입니다.")
    case is (String) -> String:                   // item is (String) -> String
        print("Index - \(index): 클로저 타입입니다.")
    default:
        print("Index - \(index): 그 이외의 타입입니다.")
    }
    
    /*
     is 일때는 그냥 쓰면 되지만 as일때는 바인딩 해서 사용해야하는 걸 알고 있어야함
     즉 Any 타입에 있는 걸 단순 타입 비교시 is
     Any 타입에 있는 걸 바인딩 하여 성공하는경우 as로 타입 캐스팅 (바인딩 하여 실제 활용하는 경우)
     let num = item as? Double  원래는 다운 캐스팅이라 ? 해줘야 하지만
     case let num as Double는 성공 경우에만 담기기 때문에 실패할 경우가 없다고 생각하는 것임 그래서 여긴 ? 빠져있음
     */
}






/*:
---
* 옵셔널값의 Any 변환
---
*/
/**==================================================================
- 의도적인 옵셔널값의 사용
- Any는 모든 타입을 포함하므로, 의도적인 옵셔널값을 사용하려면 Any타입으로 변환하면
  컴파일러가 알려주는 경고를 없앨 수 있음
 
- 왜?
- 옵셔널값은 임시적인 값일 뿐이므로, 일반적으로 개발자들은 옵셔널 바인딩을 해서
  언래핑해서 안의 값을 사용해야함 ===> 그래서 경고를 통해 알려줌
  (Any로 변환하겠다는 것은 그 자체를 사용하겠다는 의미임 ===> 경고 없음)
==================================================================**/



let optionalNumber: Int? = 3
print(optionalNumber)          // 경고
print(optionalNumber as Any)   // 경고 없음



// 중요한건 아님 알고만 넘어가자



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
