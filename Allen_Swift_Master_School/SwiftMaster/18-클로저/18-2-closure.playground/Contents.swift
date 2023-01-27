import UIKit

/*:
 ## 함수와 클로저의 형태 비교
 * 클로저의 형태
 ---
 */

// 함수의 형태

func add(a: Int, b: Int) -> Int {
    let result = a + b
    return result
}



// 클로저의 형태

let _ = {(a: Int, b: Int) -> Int in
    let result = a + b
    return result
}


// 클로저의 형태(타입 추론이 가능한 경우)

let _: (Int, Int) -> Int = {(a, b) in
    let result = a + b
    return result
}

/*
 이렇게 타입이 확실한 경우에는 클로저에서는 매개변수 타입을 생략할 수 있고 반환타입 또한 리턴을 보고 컴파일러가 타입추론을 하기때문에 생략이 가능함
 함수에서는 명확하게 해줘야 했지만 클로저 같은경우에는 이와같이 생략가능
 */


/*:
 ## 클로저의 형태
 * 가장 많이 사용하는 형태: 리턴형에 대한 표기를 생략 가능
 ---
 */

let aClosure1 = { (str: String) in  // (str: String) -> String
    return "Hello, \(str)"
}



let aClosure2: (String) -> String = { (str) in     //아규먼트 레이블을 따로 사용하지 않음
    return "Hello, \(str)"
}



let aClosure3 = {  // () -> () in
    print("This is a closure.")
}



/*:
 ---
 * 파라미터의 타입의 생략도 대부분 가능하다.
 ---
 */

let closureType4 = { str in               // 컴파일러가 타입 추론 가능한 경우 생략 가능
    return str + "!"
}

/*
 리턴 타입을 보고 문자열과 더하기를 하고 있으니 컴파일러가 str도 문자열이군아 알고있기 때문에 생략이 가능 한것임
 Swift는 같은 타입끼리만 연산 가능하기 때문에 str 문자열이네 하고 타입 추론을 해주는것
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
