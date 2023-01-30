import UIKit

/*:
 ## 2) 기타 고차함수
 * 4 - forEach함수
 ---
 */
/**====================================================
 - 기존 배열 등의 각 아이템을 활용해서
   각 아이템별로 특정 작업(작업 방식은 클로저가 제공)을 실행
 - (각 아이템을 활용해서 각각 특정 작업을 실행할때 사용)
 ======================================================**/


let immutableArray = [1, 2, 3, 4, 5]

//immutableArray.forEach(<#T##body: (Int) throws -> Void##(Int) throws -> Void#>)
// 인풋으로 인트형이 들어오고 반환은 Void 즉 반환 없이 작업을 들어오는 클로저나 함수에서 하고 끝내겠다는 뜻임

immutableArray.forEach { num in
    print(num)
}

immutableArray.forEach { print("숫자: \($0)") }


/*
 map 함수랑 햇갈릴 필요 없음 map함수는 각각의 아이템을 매핑하여 새로운 배열을 반환하는 거고
 forEach함수 같은 경우는 각각의 아이템별로 특정 작업을 하는 거다 라고 생각하면 편함
 */


/*:
 ---
 * 5 - compactMap함수
 ---
 */
/**====================================================
 - 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
   변형하되, 옵셔널 요소는 제거하고, 새로운 배열을 리턴
 - (map + 옵셔널제거)
 - 옵셔널은 빼고, 컴팩트(compact)하게
 - (옵셔널 바인딩의 기능까지 내장)
 ======================================================**/


let stringArray: [String?] = ["A", nil, "B", nil, "C"]


var newStringArray = stringArray.compactMap { $0 }
print(newStringArray)

/*
 즉 옵셔널 배열이 있을때 안에 nil을 다 제거하고 옵셔널 배열까지 바인딩을 통하여 새로운 배열(옵셔널을 벗겨낸 배열)을 만드는 것을 말함
 즉 스트링 옵셔널 타입 배열이라면 내부적으로 nil요소 제거 바인딩을 통하여 남은 요소를 스트링 배열로 만들어 반환
 compact : 1.형용사 (같은 종류의 일반적인 제품보다) 소형의[간편한] 2.형용사 (공간이) 작은
 옵셔널이 상위 개념이니까 작게 만들어 준다고 생각하면 이해하기 쉬움
 */

let numbers = [-2, -1, 0, 1, 2]


var positiveNumbers = numbers.compactMap { $0 >= 0 ? $0 : nil }
// 0보다 작으면 nil로 아이템이 바뀌는 것임 [nil, nil, 0, 1, 2]
// compactMap 함수를 이용했기에 nil 요소를 제거 하고 남은 요소들만 해당 타입에 맞는 배열로 반환

print(positiveNumbers)

// 사실 이런 경우는 filter로 가능             : 옵셔널 까지 벗겨내야 해서 map까지 사용한게 아래
//numbers.filter { $0 >= 0 }



// compactMap은 아래와 같은 방식으로도 구현 가능

newStringArray = stringArray.filter { $0 != nil }.map { $0! }
print(newStringArray)

/*
 추가적으로 꼭 해당 타입으로 반환하지 않아도 됨 String타입으로 반환도 가능함 어짜피 map에 기능이 있기 때문임
 */



/*:
 ---
 * 6 - flatMap함수
 ---
 */
/**====================================================
 - 중첩된 배열의 각 배열을 새롭게 매핑해서(매핑방식은 클로저가 제공)
 - 내부 중첩된 배열을 제거하고 리턴
 - (중첩배열을 flat하게 매핑)
 ======================================================**/


var nestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

print(nestedArray.flatMap { $0 })

// 중첩 배열을 벗겨서 하나의 배열로 만들어 주는 것임 flat: 평평한 (형용사)




var newNnestedArray = [[[1,2,3], [4,5,6], [7, 8, 9]], [[10, 11], [12, 13, 14]]]

var numbersArray = newNnestedArray
                            .flatMap { $0 }
                            .flatMap { $0 }

print(numbersArray)


// 이렇게 3중 배열은  .flatMap 두번하면 하나의 배열로 평평하게 만들 수 있음




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
