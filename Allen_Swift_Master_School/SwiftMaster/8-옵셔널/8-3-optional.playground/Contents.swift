import UIKit

/*:
 ## 옵셔널 체이닝(Chaining)
* 옵셔널 체이닝 (Optional Chaining) 문법
---
*/
// 옵셔널타입에 대해 접근연산자를 사용하는 방법

class Dog {
    var name: String?
    var weight: Int
    
    init(name: String, weight: Int) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(self.name)가 앉았습니다.")

//        if let name = self.name{          이렇게 구현해서 옵셔널 값 벗겨서 출력하게 구현해도 됨
//            print("\(name)가 앉았습니다.")
//        }
    }
    
    func layDown() {
        print("누웠습니다.")
    }
}


class Human {
    var dog: Dog?
}


// 옵셔널타입에 대해, "접근연산자"를 사용할때, ?(물음표)를 붙여서, 앞의 타입이 값이 nil을 가질 수도 있음을 표시


var choco = Dog(name: "초코", weight: 15)
choco.name
choco.sit() // 옵셔널 스트링형이라 이렇게 나오는게 맞음


// 자료형을 옵셔널 Dog로 해주면 속성접근시 ?가 자동으로 붙음 이러한 개념이 옵셔널 채이닝임
var choco2: Dog? = Dog(name: "초코", weight: 15)
choco2?.name = "초코얌"
choco2?.sit()              // Optional("초코얌")가 앉았습니다.
/*
 이유는 choco2 변수의 타입이 옵셔널일 경우에 이 변수의 타입이 옵셔널일 가능성이 있다고 반드시 써줘야함
 */


var human = Human()
human.dog = choco2
human.dog?.name // human.dog.name 이렇게 적으면 안됨 Dog? 으로 선언해줘서 해당변수가 옵셔널 타입이라고 알려주고 속성 접근해야함
print(human.dog?.name)     // Optional("초코얌")



var human2: Human? = Human()
human2?.dog = choco2
human2?.dog?.name
//human2 = nil
print(human2?.dog?.name)      // Optional("초코얌")
// 해당 타입을 옵셔널로 타입으로 선언했다고 이런식으로 접근 해줘야함



/**============================================================================
- 옵셔널 체이닝 (옵셔널 타입에 대해, 접근연산자 호출하는 방법)
- 1) 옵셔널체이닝의 결과는 항상 옵셔널이다.
- 2) 옵셔널체이닝에 값 중에서 하나라도 nil을 리턴한다면, 이어지는 표현식을 평가하지 않고 nil을 리턴
===============================================================================**/

// 1. 즉 앞에 ?가 하나라도 있으면 결과값은 옵셔널이다 생각해야함 ex human2?.dog?.name
// 2. ex human2?.dog?.name 예를 들어 human2 가 nil이면 뒤에 속성에 접근을 할 수도 없음 그래서 앞에 하나라도 nil이면 바로 nul을 리턴 하는 것임
/*:
---
* 실제 사용시에는 결국, Unwrapping해서 사용해야함
---
*/

// 1) 앞의 옵셔널타입에 값이 있다는 것이 확실한 경우

print(human2!.dog!.name)          // name 자체가 옵셔널타입이기 때문에 Optional("초코얌")
print(human2!.dog!.name!)
print(human2!.dog!.weight)        // weight 자체는 옵셔널타입이 아니기 때문에   15



// 2) if let 바인딩

if let name = human2?.dog?.name {    // Optional("초코얌")
    print(name)                      // 초코얌
}



// 3) Nil-Coalescing 연산자

var defaultName = human2?.dog?.name ?? "멍탱구리"
print(defaultName)

// 이럴때는 무조건 문자열이 나오는 것임 해당 인스턴스 즉 변수안에 값이 다 있다면 풀려서 문자열이 담기고
// 못 담길때는 기본적으로 "멍탱구리" 라는 문자열이 담기니까




/*:
 ## 활용 예시(헷갈릴 수 있는 부분 정리)
* 1) 옵셔널 체이닝 - 함수 관련 표기법
---
*/
class Cat {
    var name: String?
    
    var myMaster: (() -> Person?)? // 옵셔널 함수 타입, 옵셔널 클로저 : 함수가 있을수도 없을수도 있다. 만약 함수가 있다면 인풋 값은 없고 반환시 Person이 있을수도 없을 수도 있다
    
    init(aFunction: @escaping () -> Person?) {
        self.myMaster = aFunction   // 들어오는 함수를 외부에 저장하려고 할때 클로저 형태로 저장되기때문에 즉 이 스택 프레임을 벗어나서 큐에 저장해야하기 때문에 @escaping 키워드 사용
    }
}


class Person {
    var name: String?
}


// 함수를 정의
func meowmeow() -> Person? {
    let person = Person()
    person.name = "Jobs"
    return person
}


// 예제를 위한 예제임 ⭐️

                           // 정의한 함수를 할당
var cat: Cat? = Cat(aFunction: meowmeow) // 옵셔널이라 var로 만들어야함


var name = cat?.myMaster?()?.name               // Optional("Jobs")
/*
 보면 ()소괄호 앞뒤에 ? 가있음 이게 앞뒤로 의미하는 바가 다름 앞에 붙은 ?는 함수가 없을 수도 있다. (() -> Person?)?
 뒤에붙은 ?는 Person이 없을 수도 있다 를 의미함 Person?
 
 cat?.myMaster?()?.name
 cat 이라는 변수에 Cat이 있을수도 있다 없을 수도 있다. myMaster?() myMaster에 함수가 있을수도 없을 수도 있다.
 ?.name 함수의 결과 같이 있을 수도 없을 수도 있다. 있다면 해당 결과에 해당하는 Person에 속성 name을 가져와라
 */
print(name)


if var name = cat?.myMaster?()?.name  {
    print(name)
}

/*:
---
* 2) 옵셔널 체이닝 - 딕셔너리 관련 표기법
---
*/
class Library1 {
    var books: [String: Person]? // 딕셔너리를 저장하는데 딕셔너리가 있을 수도 없을 수도 있다 옵셔널 딕셔너리 타입임
}


var person1 = Person()
person1.name = "Jobs"
print(person1.name)


var person2 = Person()
person2.name = "Musk"
print(person2.name)



var library = Library1()
library.books = ["Apple": person1, "Tesla": person2]



library.books?["Apple"]?.name
library.books?["Tesla"]?.name
// library.books?["Ap"]?.name  키값 Ap에 해당하는게 없을 수도 있으니

// 1. books?  ====> 딕셔너리 자체가 없을 수 있음을 의미
// 2. books?["Apple"]?  ====> 딕셔너리의 결과값이 없을 수 있음을 의미



// 실제로 사용하려면? ===> 옵셔널 벗기고 사용해야함

if let name = library.books?["Apple"]?.name {
    print("이름:", name)
}




/*:
---
* 3) 옵셔널 체이닝에서 함수의 실행은?
---
*/
/**=================================================================
- 옵셔널 타입에 접근해서 사용하는 함수는 앞의 타입을 벗기지 않아도 사용가능 함.
  (함수자체가 옵셔널 타입은 아니기 때문에 함수를 벗겨서 사용할 필요없음)
 
- 1) 함수가 리턴형이 없는 경우
     (1) 타입에 값이 있으면 함수실행
     (2) 타입에 값이 없으면 nil
 
- 2) 함수가 리턴형이 있는 경우
     (1) 타입에 값이 있으면 옵셔널 리턴 타입으로 반환 (원래 리턴형이 옵셔널이 아니더라도)
     (2) 타입에 값이 없으면 nil로 반환
====================================================================**/


var bori: Dog? = Dog(name: "보리", weight: 20)

bori?.layDown()          // ⭐️ 앞의 타입이 옵셔널이라고 해서 메서드가 실행이 안되는 것은 아님
bori?.sit()              // Optional("보리")가 앉았습니다.

//if let b = bori {
//    b.sit()               즉 이렇게 까지 메서드를 실행할때는 벗겨서 사용할 필요가 없다는 뜻임
//    b.layDown()
//}

bori = nil
bori?.layDown()          // 타입의 값이 nil이면, 함수가 실행이 되지 않고 nil을 반환


// 사실 결론은 간단. 옵셔널 체이닝에서 함수(메서드 실행)의 경우 크게 신경을 쓰지 않고 호출하면 됨
// (옵셔널이라는 것은 변수 안의 값에 대한 문제일 뿐)

/* 만약 Dog 클래스의 layDown() 매서드를 이렇게 했다고 가정하에
func layDown() -> Int{
    print("누웠습니다.")
    return 0
}
 
 위 코드를 print(bori?.layDown()) 해도 반환타입이 Int?가 아니라 Int여도
 Optional(0)이 출력됨 이런 경우에만 그 값을 벗겨서 사용하면됨 일반적으로 메서드는 크게 신경쓰지 않고 호출
 Optional(0)이 나오는 이유 bori 앞에있는 변수가 옵셔널인 가능성을 가지고 있기에 이 전체 bori?.layDown() 값이 옵셔널을 가질수 있는
 가능성을 가져가기 때문에 단순 Int형이 아니라  Optional(Int)이렇게 나오는 것임 즉 bori?.layDown() 이런 경우에는
 layDown() 이 아무리 반환값이 Int형이라도 Optional(Int)형이 반환 되는 것임 리턴형이 있을때는 이러한 것을 고려 하면 되지만
 리턴형이 없는경우에는 그냥 실행 하면 되는 것임, 타입에 값이 있으면 함수실행 하겠군아!!
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
