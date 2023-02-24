import UIKit

/*:
 # Part26 - 메모리 안전
 */
/*:
 ## 메모리 안전(Memory Safety)의 개념
 * 메모리 접근에 대한 충돌(confilct) 이해하기
 ---
 */
//:> 멀티쓰레드(Multi Thread)의 환경에서만 메모리 충돌이 일어나는건 아님

// 싱글 쓰레드 환경에서도 어떤 메모리에 동시접근 할 수 있는 환경이 발생할수 있음
var stepConflict = 1


// 변수 stepConfilt에 장기적인 쓰기 접근 (입출력 파라미터)
func increment(_ number: inout Int) {
    number += stepConflict    // 변수 stepConfilt에 읽기 접근  // number = number + stepConflict
}

//increment(&stepConflict)   // 메모리에 동시접근으로 인한 문제 발생가능

/*
 😀 inout 키워드 사용하면 외부 변수를 그대로 집어 넣었다 뺄수 있다고 했음
 주소값을 넘겨서 주소값을 내부에서 계속 가리키게 하기 때문에
 위 코드는 외부 변수 주소값을 넘겼는데 함수 내부에서 또 그 변수를 더하여 넣고 있음
 그러면 컴퓨터는 어떤 숫자를 읽고 저장해야 하는지 구분이 어려움 : 동시에 읽으면서 쓰는 상황이 발생하고 있는 것임
 */



/**=================================
 - 위와 같은 문제는 다른 변수를 만들어서 해결
 ===================================**/


var stepSize = 1
var copyOfStepSize = stepSize    // 명시적으로 복사본 변수를 만들어서 해결


// 변수 stepSize에 장기적인 쓰기 접근 (입출력 파라미터)
func incrementing(_ number: inout Int) {
    number += stepSize         // 변수 stepSize에 읽기 접근       // number = number + stepSize
}



incrementing(&copyOfStepSize)


// 원본을 다시 바꾸기 ⭐️
stepSize = copyOfStepSize




/*:
 ---
 * 동일한 함수의 여러 '입-출력 매개변수'로 단일 변수를 전달하는 것도 에러
 ---
 */

func balance(_ x: inout Int, _ y: inout Int) {  // 평균값 설정하는 함수
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30


// 입출력 파라미터로 동일한 변수를 전달하고 있음
//balance(&playerOneScore, &playerOneScore)   // 에러 발생 ⭐️
// 함수 내부에서 동일 메모리에 접근 할것임 : 안전하지 않음

balance(&playerOneScore, &playerTwoScore)   // 에러 발생하지 않음









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
