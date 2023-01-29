import UIKit


/*:
## 클로저의 캡처
* 클로저의 Capturing Value
---
*/
/*
 클로저도 힙영역에 저장됨 컴파일 된 코드 묶음을 힙 영역에 저장하여 관리 하는 것임
 *실제로 클로저를 변수에 할당하거나 클로저를 호출하는 순간, 클로저는 자신이 참조하는 외부의 변수를 캡처함 
 (지속적으로 외부 변수를 사용해야 하기 때문에 오류나는걸 방지 하는 것임) 그래서 유의해서 사용 해야함 참조 변수의 주소를 기억 하고 있어서 그 변수를 지속적으로 계속이용하기 때문에 값을 연산해서 저장하는 경우 중첩으로 기존값에 계속 더하는 현상이 발생함
 
 즉
 1) 함수를 변수에 할당하거나 2) 클로저를 사용하는 경우 
 힙(Heap)에 해당 메모리주소를 저장 및 (외부의)필요한 변수를 캡처
 
 +
 
 변수를 캡처하는 함수(중첩 함수의 내부 함수) - 캡처 현상의 발생
 이내용은 함수안에 함수 즉 중첩 함수를 반환할때 그 반환 함수를 변수에 담을때 그 함수에서 자신이 참조하는 외부의 변수를 캡처됨
 즉 1번 내용에 해당하는 개념인것
 
 +
 
 결론적으로 클로저는 레퍼런스 타입임
 // 레퍼런스 타입
 var dodoFunc = squareFunc
 dodoFunc(20)
 // 클래스에서 배웠던 것과 마찮가지로 이렇게 하면 두변수다 같은 클로저를 가리키게 되는것임
 // 왜냐 클레스와 동일한 레퍼런스 타입이기 때문임
 
 
 */

var stored = 0


let closure = { (number: Int) -> Int in
    stored += number
    return stored
}




closure(3)

closure(4)   // 어떤 결과가 나올까?

closure(5)

stored = 0

closure(5)   // 어떤 결과가 나올까?







/*:
 ## 캡처 현상
 * 일반적인 함수
 ---
 */
// 함수 내에서 함수를 실행하고, 값을 리턴하는 일반적인 함수

func calculate(number: Int) -> Int {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    let result = square(num: number)
    
    return result
}


calculate(number: 10)
calculate(number: 20)
calculate(number: 30)



/*:
 ---
 * 변수를 캡처하는 함수(중첩 함수의 내부 함수) - 캡처 현상의 발생
 ---
 */
/**=======================================================
 - 아래와 같은 경우, 중첩함수로 이루어져 있고
 - 내부 함수 외부에 계속 사용해야하는 값이 있기 때문에 캡처 현상이 발생
 
 - (함수/클로저를 변수에 저장하는 시점에 캡처) ==> 클로저도 레퍼런스 타입
=========================================================**/


func calculateFunc() -> ((Int) -> Int) {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    return square       // square() 함수를 실행 하는게 아니라 그냥 가르키고 있음
}




// 변수에 저장하는 경우(Heap 메모리에 유지)
var squareFunc = calculateFunc()        // 이렇게 하면 함수를 리턴하니까 square 함수가 squareFunc 이 변수에 저장 되는 것임

// alculateFunc() 순간 함수 리턴하며 변수에 저장 하려고 할때 힙에 저장 되고 squareFunc 에는 그 저장 된 주소만 저장됨(main스택영역에서)

squareFunc(10)
squareFunc(20)
squareFunc(30)



// 변수에 저장하지 않는 경우
// (Heap메모리에 유지하지 않음)

calculateFunc()(10)//함수가 리턴 되면서10을 사용
calculateFunc()(20)
calculateFunc()(30)

// 스택 프레임만 사용 할 것임

// 레퍼런스 타입
var dodoFunc = squareFunc
dodoFunc(20)
// 클래스에서 배웠던 것과 마찮가지로 이렇게 하면 두변수다 같은 클로저를 가리키게 되는것임
// 왜냐 클레스와 동일한 레퍼런스 타입이기 때문임









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
