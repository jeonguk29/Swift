import UIKit

/*:
 # Part18-1 - 고차함수
 */
/*:
 ## 1) 기본 고차함수 3가지
 * 고차함수(Higher-order Function)란?
 ---
 */
/**==========================================================
 - 고차원의 함수
 - 함수를 파라미터로 사용하거나, 함수실행의 결과를 함수로 리턴하는 함수


 - 일반적으로 함수형 언어를 지향하는 언어들에 기본적으로 구현되어 있음
 - 아래의 3가지 함수를 다룸

 - 1) map 함수
 - 2) filter 함수
 - 3) reduce 함수

 - (추가적으로: forEach, compactMap, flatMap)


 - Sequence, Collection 프로토콜을 따르는 컬렉션(배열, 딕셔너리, 세트 등)
   에 기본적으로 구현되어 있는 함수
 - (Optional타입에도 구현되어 있음)
 ============================================================**/

/*:
 ---
 * 1 - map함수
 ---
 */
/**====================================================
 - 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
   새로운 배열을 리턴하는 함수
 - (각 아이템을 매핑해서, 변형해서 새로운 배열을 만들때 사용)
 ======================================================**/


let numbers = [1, 2, 3, 4, 5]

//numbers.map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)   T는 재네릭임 어떠한 타입으로도 변형 될 수 있는 타입

// 즉 인풋이 정수형이고 아웃풋은 어떠한 타입도 괜찮다는 함수를 요구 하고 있음

var newNumbers = numbers.map { (num) in
    return "숫자: \(num)"         // 클로저를 사용하여 보냄
}

print(newNumbers)

newNumbers = numbers.map { "숫자: \($0)" } // 매개변수 in 키워드 생략 한줄이라 리턴 키워드 생략 위랑 완전 코드임
print(newNumbers)

var aaa = numbers.map { (num) in
    return num * 1000         // 클로저에서 변형하는 방법에대하여 제시 해줘야함
}
print(aaa)

//print(numbers)
//print(newNumbers)   // ["숫자: 1", "숫자: 2", "숫자: 3", "숫자: 4", "숫자: 5"]





var alphabet = ["A", "B", "C", "D"]


//names.map(<#T##transform: (String) throws -> T##(String) throws -> T#>)  기존 배열안에 어떤타입이냐에 따라 인풋 타입이 바뀌는 것임



var newAlphabet = alphabet.map { (name) -> String in
    return name + "'s good"
}


print(alphabet)
print(newAlphabet)


/*
 서버에서 데이터 가져와서 변형시킬때 for문으로 돌려서 변형 시키는  보다 훨신 더 map함수를 이용하면 간편하게 변형 가능함
 
 요약 배열이 있어야 한다 배열에 딸린 메서드이다 이놈은 파라미터로 함수를 필요로 한다. 일반적으로 이함수를 클로저 형태로 전달을 한다.
 클로저에서 변형하는 방법에대하여 제시 해줘야한다. == 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
 새로운 배열을 리턴
 */


/*:
 ---
 * 2 - filter함수
 ---
 */
/**====================================================
 - 기존 배열 등의 각 아이템을 조건(조건은 클로저가 제공)을
   확인후, 참(true)을 만족하는 아이템을 걸러내서 새로운 배열을 리턴
 - (각 아이템을 필터링해서, 걸러내서 새로운 배열을 만들때 사용)
 ======================================================**/


let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

//names.filter(<#T##isIncluded: (String) throws -> Bool##(String) throws -> Bool#>)
// 문자열을 받아서 참과 거짓으로 리턴하는 클로저를 구현하면 되겠군아 생각하면 됨


var newNames = names.filter { (name) -> Bool in
    return name.contains("B")
}


print(newNames)






let array = [1, 2, 3, 4, 5, 6, 7, 8]


//array.filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)


var evenNumersArray = array.filter { num in // (num: Int) 정수형인걸 알고 있음 타입추론이 되기 때문에 생략 가능한 것임
    return num % 2 == 0 // 모듈러 연산자 이용 나머지 0이 즉 참인것만 반환 == 짝수만 반환 반복문으로 뽑아 내는 것 보다 간단
}

evenNumersArray = array.filter { $0 % 2 == 0 }

print(evenNumersArray)


// 함수로 전달해보기

//func isEven(_ i: Int) -> Bool {
//    return i % 2 == 0
//}


//let evens = array.filter(isEven)          이렇게 클로저가 아니라 직접 만든 함수 자체를 전달 하는 것도 가능함  : 함수를 가리킴


/*
 이렇게 필터링 두번 가능함 array.filter { $0 % 2 == 0 } 이렇게 했을때 나온것도 배열임 그걸 또한번 필터링함
 첫번째 필터링시 2,4,6,8 두번째 필터링시 2, 4
 */

evenNumersArray = array.filter { $0 % 2 == 0 }.filter { $0 < 5 }

print(evenNumersArray)

var aaa2 = [2,4,6,8].filter { num in
    return num < 5
}
print(aaa2) // 이코드랑 같은 것임

// 활용도가 높음 여러번 필터링 할 수 있으니



/*:
 ---
 * 3 - reduce함수
 ---
 */
/**====================================================
 - 기존 배열 등의 각 아이템을 클로저가 제공하는 방식으로 결합해서
   마지막 결과값을 리턴(초기값 제공할 필요)
 - (각 아이템을 결합해서 단 하나의 값으로 리턴)
 ======================================================**/


var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//numbersArray.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result#>)

// 파라미터를 두개 받는데 하나는 Result이고 나머지 하나는 함수 타입임 코드를 보고 이해하는게 빠름

var resultSum = numbersArray.reduce(0) { (sum, num) in
    return sum + num
}

print(resultSum)

/*
 처음 reduce 파라미터에 설정한 초기값 0 이 sum 자리에 들어가고 배열의 0번째 1이 num 자리
 두개를 더해서 reduce(1) 첫번째 파라미터에 값을 교체 하고 다시 위와 같은 로직 이 1이 sum자리에 1번째 인덱스 값 2를 num자리에
 두개를 더해서 reduce(3) 첫번째 파라미터에 값을 교체 하고 다시 위와 같은 로직 이 3이 sum자리에 2번째 인덱스 값 3를 num자리에
 
 reduce 단어 뜻 그대로 기존 배열에 아이템을 줄여가면서 연산 결과 하나를 반환 하는 것임
 */


resultSum = numbersArray.reduce(100) { $0 - $1 }    // 이렇게 하면 결론적으로 100에서 45를 빼는것임

print(resultSum)


var aaa3 = numbersArray.reduce("0") { (result, item) in
    return result + String(item)
}
print(aaa3)


/*:
 ---
 * map / filter / reduce의 활용 ⭐️
 ---
 */
numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은?


var newResult = numbersArray
                        .filter { $0 % 2 != 0 }
                        .map { $0 * $0 }
                        .reduce(0) { $0 + $1 }

print(newResult)


// 1, 9, 25, 49, 81 ===> 165



var newResult2 = numbersArray.filter { num in
    return num % 2 != 0
}.map { num in
    return num * num
}.reduce(0) { first, item in
    return first + item
}

print(newResult2)

/*
 이렇게 실제 앱을 만들때 데이터를 다루기 위해서 많이 활용함
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
