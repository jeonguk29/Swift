import UIKit


/*:
## 2) 멤버의 확장(메서드)
 * 2-1. (타입)메서드의 확장
 ---
 */
// 애플이 만든 타입메서드 예시

Int.random(in: 1...100)


extension Int {
    static func printNumbersFrom1to5() {
        for i in 1...5 {
            print(i)
        }
    }
}


// 항상 1부터 5까지를 출력

Int.printNumbersFrom1to5()



/*:
---
* 2-2. (인스턴스)메서드의 확장
---
*/
// Int타입에 특정 프린트 구문 확장해보기

extension String {
    func printHelloRepetitions(of times: Int) {
        for _ in 0..<times {
            print("Hello \(self)!")
        }
    }
}



"Steve".printHelloRepetitions(of: 4)
//"Swift".printHelloRepetitions(of: 5)
    

//Hello Steve!
//Hello Steve!
//Hello Steve!
//Hello Steve!


// 이렇게 하는 걸 소급 모델링이라고 했음 이미 애플이 만든걸 뜯어 고칠 수 없으니까 소급해서 적용 할 수 있도록 확장에서는 그걸 적용함

/*:
---
* mutating 인스턴스 메서드의 확장
---
*/
//:> 구조체(열거형)에서, 자신의 속성을 변경하는 메서드는 mutating키워드 필요

// 제곱하는 메서드 만들어 보기

extension Int {
    mutating func square() {    // 기존 메서드와 동일하게, mutating 키워드 필요
        self = self * self
    }
}

// 값 타입(구조체, 열거형)에서 기본적으로 인스턴스 메서드 내에서 속성을 수정할 수 없음
// 수정하려면, mutating(변형되는)키워드를 붙이면 속성 수정 가능해짐(클래스와 구조체의 차이)




var someInt = 3
someInt.square()    // 9








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
