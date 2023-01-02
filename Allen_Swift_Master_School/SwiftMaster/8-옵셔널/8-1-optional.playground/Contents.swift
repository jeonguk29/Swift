import UIKit

/*:
 # Part8 - Optionals(옵셔널)
 */
/*:
---
* 타입의 기본 개념에 대한 이해
---
*/
// 스위프트는 왜 옵셔널이라는 개념을 도입했을까?
// 모든 프로그래밍에서 아래와 같은 상황은 항상 골치거리임


var yourName: String        // 선언
//yourName = "홍길동"           // 값을 저장하지 않는다면..

//print(yourName)   // (만약 저장과정이 없다면) 메모리에 저장된 값이 없는데 접근 ===> 🔸"에러"
// 자료형이라는 것이 메모리에 반드시 이 타입의 값이 들어있다라고 알려주는 것임
// 값도 없는데 접근하면 어떤 언어를 막론하고 에러가 남 앱같은 경우에는 꺼져버림



/*:
---
* 타입(Type)
---
*/
// 지금까지의 타입 선언

let name: String = "Jobs"        // 명시적
let newName = "Musk"             // 암시적
var myAge = 20                   // 암시적
let myGrade: Double = 3.54       // 명시적

// 선언이후에 값이 있어야함 즉 초기화가 되어야함 초기화 없이 값 접근시 오류가 발생
/*:
---
* 옵셔널 타입(Optional Type)
---
*/
// 모든 타입의 뒤에 ? 물음표를 붙이면 옵셔널 타입이 된다.

var num: Int? = 3
var yourAge: Int? = nil
var yourGrade: Double? = nil
var name1: String? = "Jobs"
// var num2 = nil 이렇게 하면 오류남 어떤 옵셔널 타입으로 줘야하는지 몰라서


num = nil
name1 = nil


// 값이 없어도 되는 타입으로 선언 했기 때문에, 값이 없어도 괜찮음


//:> nil - 값이 없음을 나타내는 키워드 (실제 값이 없음이 아님)
// 하지만 옵셔널 타입의 변수가 nil을 가지고 있을때 값을 풀어버리면 크래시가 발생함

/*:
---
* 옵셔널, 옵셔널 타입의 기본 개념에 대한 이해
---
*/

// 메모리 공간에 "임시적인 타입"을 넣어놓으면 어떨까?


var optionalName: String?
//optionalName = "홍길동"


print(optionalName)   // 에러가 나지 않음 (옵셔널은 값이 없다는 것을 나타내는 키워드)



/**=========================================
- 옵셔널 타입 선언의 기본 규칙
- 1) nil 대입 가능
- 2) 자동 초기화 (값을 넣지 않을 시에 nil로 초기화) ⭐️
============================================**/




/*:
---
* 정식문법 표기
---
*/

let num1: Int? = 2             // 간편표기
let num2: Optional<Int> = 0    // 정식문법




/*:
---
* 옵셔널 타입 연습
---
*/
//var optionalNum = nil         // 불가능한 형태

var optionalNum: Int? = nil     // (추론할 형식이 없기 때문에 반드시 타입 어노테이션으로 초기화해야됨)
optionalNum = 10

// 값이 없을 수도 있는 (임시적인)타입이야


print(optionalNum)      // Optional(10)



//옵셔널 타입은 반드시 변수로 선언해야함

let str: String = "Swift"
var optionalStr: String? = nil      //옵셔널 스트링 타입 ====> (값이 없을 수도 있는 타입이다)


// let, 상수로 선언시 값이 바뀔일이 없음 그럼 nil 이면 값이 없다는걸 의미 하지만 값이 들어갈 수 있어야함 값이 들어갈 수 있으려면 var 변수로 선언 되어야함



var a: Int? = 7  // 옵셔널 인트
var b = a        // 값을 복사해서 담는 다면 타입은?

print(b)




var c: Int = 5
b = c     // Int를 Int?타입에 담을 수는 있다. (어쨌든 타입이 Int? 타입으로 바뀌어서 담김)

print(b)

// 옵셔널 Int의 그릇이 좀더 크기 때문에 Int형이 담기는 것임 (Int,nil 을 담을 수 있는 옵셔널 상자 즉 입시 타입이니까 )



/*:
---
* 옵셔널 타입끼리의 연산은 불가능
---
*/
//:> 옵셔널 타입끼리의 계산은 당연히 불가능

var numA: Int? = 3
var numB: Int? = 7



//print(numA + numB)

// 임시 타입이기 때문에 불가능 한것임 안에 있을지도 없을 지도 모르는 상자가 우선 적으로 있기 때문에
// 연산시 풀어서 사용해야함









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
