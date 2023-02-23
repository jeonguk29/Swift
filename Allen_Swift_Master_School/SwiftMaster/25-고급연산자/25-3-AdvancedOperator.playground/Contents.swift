import UIKit


/*:
 ## 논리연산자와 단락 평가
 * 논리 연산자(Logical Operators)
 ---
 */
// 1) Logical NOT Operator
!true
!false


// 2) Logical AND Operator(앤드, 그리고)
true && true
true && false
false && true   // 컴퓨터의 입장에서 뒤에 true는 확인하지 않음 앞에서 이미 false이기 때문에 볼 필요도 없는 것임 이런개념이 단락평가
false && false


// 3) Logical OR Operator(또는)
true || true
true || false   // 앞에 true만 확인하면 뒤에것은 확인 하지도 않음
false || true
false || false


/**======================================================================================
 - false && true 에서 false만 확인 (항상 false) ====> 왜냐하면, 2번째 결과에 상관없이 false로 평가되기 때문
 - true || false 에서 true만 확인 (항상 true) ====> 왜냐하면, 2번째 결과에 상관없이 true로 평가되기 때문
=========================================================================================**/


/*:
 ---
 * 단락 평가(Short-circuit Evaluation)
 ---
 */
/**===========================================================
 - 스위프트의 논리 평가식은 "단락 평가" 방식을 사용
 - 단락평가: 논리 평가식에서 결과도출에 필요한 최소한의 논리식만 평가
          (예: 참을 찾을때 까지만 실행하고, 참을 찾으면 나머지 표현식은 평가하지 않음)
          (최소한의 코드만 실행 - Short-circuit evaluation)
 - 참고: 논리연산자 우선순위 1) && 2) ||
 =============================================================**/


var num = 0


func checking() -> Bool {
    print(#function)    // 실행되고 있는 함수의 이름을 출력
    num += 1    // 이 함수가 실행될때 항상 외부의 변수 값을 변화시키는데 이것을 "사이드 이펙트"라고함
    return true // 항상 참이나옴
}

//checking()  // 즉 이 함수를 몇번 실행시키는지에 따라서 num의 값이 달라 질 수 있는 것임
//checking()

// if문의 조건식에서 함수를 호출하는 경우

if checking() || checking() {    // &&으로 바꿔보기
             // &&
    // 이경우에는 앞에 함수만 보면 항상 true이니까 뒤에는 보지도 않음
}


num     // || 일때는 이변수의 결과 값이 항상 1이나옴
// && 으로 바꿔 실행하면 2가나옴   &&이기 때문에 앞에가 true라도 뒤에를 한번 더 실행시키기 때문임



/*
 이런 개념을 말한 이유는 이런 단락평가 방식으로 인해서 어떠한 변수의 값이 달라질 수 있다는것을 주의해야되기 때문임
 */

/*:
 ---
 * 단락 평가에서 발생할 수 있는 문제 경우의 예시
 ---
 */
var doorCheck = 0
var passwordCheck = 0

func doorCodeChecking() -> Bool {
    doorCheck += 1
    print(#function)
    return true
}

func passwordCodeChecking() -> Bool {
    passwordCheck += 1
    print(#function)
    return true
}

// 위 두함수는 각각 외부 변수의 값을 변화시킴 사이드 이펙트가 발생하는 함수들임


// 아래 3개의 케이스에서 returnTrue 메서드는 각각 몇 번씩 호출될까?

print("\n[ 첫번째 케이스 ] =============")
// true나오네 다음꺼 true나오네 다음꺼 false네 최종 : false || 연산자네 ture네 다음꺼 ture네 다음꺼 ture네 최종 : ture
if doorCodeChecking() && passwordCodeChecking() && false || true && doorCodeChecking() && passwordCodeChecking() {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")
// 각각 2번씩 호출 되는 것을 알수 있음



print("\n[ 두번째 케이스 ] =============")
doorCheck = 0
passwordCheck = 0

if doorCodeChecking() && false && passwordCodeChecking() || doorCodeChecking() || passwordCodeChecking() {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")




print("\n[ 세번째 케이스 ] =============")
doorCheck = 0
passwordCheck = 0

if doorCodeChecking() || passwordCodeChecking() && doorCodeChecking() || false && passwordCodeChecking() {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")





/**===========================================================
 - 단락 평가로 인한 주의 ⭐️
 - 사이드 이팩트 발생시는 반드시 주의
   일부 변수가 표현식의 평가 결과로 값이 변경되는 것 (여기서는 doorCheck += 1)
   논리평가식에서 사이드 이펙트가 발생하는 경우, 단락평가로 인해 함수 등의
   실행횟수의 차이로 인해 의도치 않은 결과가 도출될 수 있음
 
   ===> 논리적인 오류가 없도록 표현식을 미리 실행하도록 코드 수정
 =============================================================**/

// 사이드이펙트 방지코드


print("\n[ 세번째 케이스를 수정한다면 ] =============")
doorCheck = 0
passwordCheck = 0

// 무조건 미리 함수를 실행하고 그결과를 담는 것임
let doorResult1 = doorCodeChecking()
let passwordResult1 = passwordCodeChecking()
let doorResult2 = doorCodeChecking()
let passwordResult2 = passwordCodeChecking()
// 함수가 이 4번은 무조건 실행 될거고 그 결과를 비교하면 사이드이펙트를 방지할 수 있음
// if문의 논리 흐름에 맞춰 실행 되는게 아니고 4번은 무조건 실행임
if doorResult1 || passwordResult1 && doorResult1 || false && passwordResult2 {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")









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
