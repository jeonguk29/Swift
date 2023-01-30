import UIKit


/*:
 ## 참고) 함수형 프로그래밍
 * 함수형 프로그래밍(Functional Programming)이란?
 ---
 */
//:> 명령형 프로그래밍
// 배열의 합을 구하는 문제 - 어떻게(how) 구현해낼까?

let numbers = [1, 2, 3]

var sum = 0

for number in numbers {
    sum += number
}

print(sum)


// 변수를 선언하고 이 변수의 값을 어떤 로직으로 구현하여 바꿀지 설계 하며 프로그래밍 하는게 명령형 프로그래밍임
// person.name = "홍길동" 어떠한 붕어빵을 찍어 냈을때 그안에 속성을 어떻게 바꿀까 직접바꿀 수도 있고 생성자 등등
// 이러한 것들도 다 명령형 프로그래밍임 어떠한 변수(속성)에 접근해서 값을 바꾼다, 바꾸기 위한 로직 설계
//:> 함수형 프로그래밍(선언형)
let newNnumbers = [1, 2, 3]
var newSum = 0


// 기존의 함수를 어떻게 조합해서 결과(what)를 만들까?

newSum = newNnumbers.reduce(0) { $0 + $1 }

print(newSum)



/**=======================================================================
 [함수형 프로그래밍]
 - 함수를 이용해서, "사이드 이펙트가 없도록" 선언형으로 프로그래밍 하는 것
   (함수형 프로그래밍은 결과를 도출하기 위해 "함수"를 사용하는 것에 지나지 않음)

 - 산에 올라가는 방법은
   1)"산을 걸어서 올라가는 방법"(명령형)  vs  2) "헬리곱터에서 정상에서 내리는 방법"(함수형)
 
 [함수형/선언형]
 - 개발자는 중간과정을 신경쓰지 않고,
 - 이미 정의된 함수를 가지고 "어떻게 조합해서 결과를 만들어 낼까"만 신경쓰면 됨
 - ==> 모두가 map/filter/reduce의 쓰는 방법을 알고 있기 때문

 - 간결한 코드 작성이 가능해짐 ⭐️
 - SwiftUI에서 사용하는 방식
==========================================================================**/



// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은?

var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]



var newResult = numbersArray
                        .filter { $0 % 2 != 0 }
                        .map { $0 * $0 }
                        .reduce(0) { $0 + $1 }

print(newResult)

/*
 아주 간단해짐 이걸 for문으로 즉 명령형 프로그래밍으로 구현하려면 복잡하고 코드 가독성 등 비교했을때 단점이 많음
 우리가 앱을 만들때 UIKit에서 만들때는 함수형 프로그래밍 방법이 아니라 명령형 프로그래밍 방법임 최근에는 이러한 함수형 프로그래밍
 패러다임이 지배하고 있음 SwiftUI에서 사용하는 방식 그래서 클로저를 자유 자재로 사용함
 */


/*
 Swift는 객체지향 프로그래밍, 프로토콜지향 프로그래밍(Swift 유일), 함수형 프로그래밍 이 3가지 패러다임을 모두 추구하는 언어임
 기존 객체지향 프로그래밍에서 상속에 문제점들을 프로토콜 지향 프로그래밍으로 보완하고 함수형 프로그래밍을 채택하여
 함수를 이용해서, "사이드 이펙트가 없도록" 선언형으로 프로그래밍 하고 개발자는 중간과정을 신경쓰지 않고,
 - 이미 정의된 함수를 가지고 "기존의 함수를 어떻게 조합해서 결과(what)를 만들까? 어떻게 조합해서 결과를 만들어 낼까"만 신경쓰면 되는 것임 이러한 함수형 프로그래밍을 FP, 선언형 프로그래밍라고 하고 이와 반대되는 개념이 명령형 프로그래밍이라는 개념임
 ex 배열의 합을 구하는 문제 - 어떻게(how) 구현해낼까?/설계
 
 */


// 추가 참고자료
// https://youtu.be/jVG5jvOzu9Y   (함수형 프로그래밍이 뭔가요? - 얄팍한 코딩사전)
// https://youtu.be/HZkqMiwT-5A   (함수형 프로그래밍이 뭐하는 건가요? - 곰튀김 님)
// https://youtu.be/cXi_CmZuBgg   (Functional Reactive Programming 패러다임 - 곰튀김 님)






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
