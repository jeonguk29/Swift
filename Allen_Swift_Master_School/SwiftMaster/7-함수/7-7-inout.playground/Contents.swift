import UIKit


/*:
 ## inout 파라미터
 * 함수를 통해, 변수를 직접 수정하고 싶은 경우는 어떻게 해야할까?
 ---
 */
//:>함수내의 파라미터는 기본적으로 값타입이고(복사되서 전달) 임시상수이기 때문에 변경 불가 원칙

var num1 = 123     // 전역변수
var num2 = 456     // 전역변수


func swap(a: Int, b: Int) {
//    var c = a
//    a = b // 상수 변경 불가
//    b = c
}


swap(a: num1, b: num2). // 값 타입이라는건 기본적으로 이 함수를 실행할때 스텍프레임이 만들어지고 매개변수 값으로 num1, num2 변수가 가진 주소안에
// 값만 복사해서 던지는 것임 그렇기 때문에 값 타입이라고 하는 것임





/*:
---
* 함수 내에서 변수를 직접 수정하도록 돕는 inout키워드 (참조로 전달)
---
*/
//:> inout 키워드(선언시),   & 사용(실행시)
num1 = 123
num2 = 456



func swapNumbers(a: inout Int, b: inout Int) { // let a 이렇게 상수로 선언 되는게 아니라 이제 진짜 num1 변수가 가진 주소값이 전달됨
    var temp = a
    a = b   // num1 = num2 실제로 이렇게 되고 있다고 생각해야함
    b = temp
}




// 함수 실행시에는 앰퍼샌드를 꼭 붙여야함

swapNumbers(a: &num1, b: &num2) // 주소를 전달함


print(num1)
print(num2)



// 입출력 파라미터는 내부적으로 copy-in, copy-out 메모리 모델를 사용하지만, 실제 원본이 전달된다고 쉽게 생각하면 됨
// *copy-in, copy-out - 값을 복사해서 함수 바디 내부로 전달하고,
// 함수가 종료될때, 아규먼트로 전달한 변수에 복사됨(함수 바디 내부에서 외부로 복사되어 전달)



/**==========================================
 - inout파라미터 사용시 주의점
 - 1) 상수(let)나, 리터럴 전달하는 것 불가능
    상수  값이 변할경우가 없기 때문에,    a: &123, b: &4562
 - 2) 파라미터의 기본값 선언을 허용하지 않음
    b: Int = 5. : 주소를 가지고 노는거라
 - 3) 가변파라미터(여러개의 파라미터)로 선언하는 것 불가능
    b: Int...     : 주소를 가지고 노는거라
 
=============================================**/









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
