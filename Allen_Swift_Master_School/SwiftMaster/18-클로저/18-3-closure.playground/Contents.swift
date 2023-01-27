import UIKit

/*:
 ## 클로저의 사용
 * 클로저를 왜 사용하는가? - 1
 ---
 */
// 1) (클로저를 파라미터로 받는 함수)정의

func closureParamFunction(closure: () -> ()) {
    print("프린트 시작") // 을 출력하고
    closure()   // 넘어오는 함수를 실행하겠다는 뜻임
}


// 파라미터로 사용할 함수/클로저를 정의

func printSwiftFunction() {          // 함수를 정의
    print("프린트 종료")
}


let printSwift = { () -> () in      // 클로저를 정의
    print("프린트 종료")
}



// 함수를 파라미터로 넣으면서 실행 (그동안에 배운 형태로 실행한다면)

closureParamFunction(closure: printSwiftFunction)   // printSwiftFunction 는 파라미터로 쓰이고 있는 것임

closureParamFunction(closure: printSwift)       // 클로저를 파라미터로 받는 함수에서 타입이 맞는 함수들이라 이렇게 던저주는게 가능





// 2) 함수를 실행할때 클로저 형태로 전달 (클로저를 사용하는 이유)


closureParamFunction(closure: { () -> () in
    print("프린트 종료")           // 본래 정의된 함수를 실행시키면서, 클로저를 사후적으로 정의 가능
})                              // (활용도가 늘어남)
/*
 즉 클로저를 정의하면서 파라미터로 바로 전달 그렇기 때문에 이름이 필요가 없는것임
 일반적으로 이렇게 많이 사용함
 */


closureParamFunction(closure: { () -> () in
    print("프린트 종료 - 1")
    print("프린트 종료 - 2")
})


/*
 클로저는 왜 이름이 필요없을까? 함수를 실행할때 전달하는 형태로 사용하기 때문에 이름이 필요없음 보통 위와같이
 (1) (클로저를 파라미터로 받는)함수를 정의:
 (2) 함수를 실행할 때 (파라미터를 클로저 형태로 전달)
 closureParamFunction이라는 함수를 호출하면서 클로저 함수를 전달  즉 클로저를 정의하면서 파라미터로 바로 전달 그렇기 때문에 이름이 필요가 없는것임 일반적으로 이렇게 많이 사용함
 (일반적으로 함수를 실행할때 클로저 형태로 전달)
 +
 (함수를 실행할때 파라미터로 전달하는 함수 -> Callback을 받기 때문에, 콜백함수라고 부름)
 즉 클로저 뿐만 아니라 (클로저를 파라미터로 받는)함수에 던저지는 애들을 다 Callback 함수라고함 결론 적으로 다시 던져지고
 내가 다시 실행되기 때문에 ex 캐치볼
 */
/*:
 ---
 * 클로저를 왜 사용하는가? - 2
 ---
 */

// 1) (클로저를 파라미터로 받는 함수)정의

func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)  // 연산 결과를 그다음 Callback함수에 파라미터로 전달
}




// 2) 함수를 실행할 때 (클로저 형태로 전달)

closureCaseFunction(a: 5, b: 7, closure: { param -> () in
    print("안녕하세요: \(param)")
})



closureCaseFunction(a: 5, b: 2, closure: { (n) in    // 사후적 정의
    print("이제 출력할께요: \(n)")
})



closureCaseFunction(a: 5, b: 2) {(number) in      // 사후적 정의
    print("출력할까요? \(number)")   // 이런식으로 소괄호를 땡겨 쓰는 형태도 가능 뒤에서 자세하게 다뤄 볼것임
}


closureCaseFunction(a: 5, b: 3) { (number) in      // 사후적 정의
    print("출력")
    print("출력")
    print("출력")
    print("값: \(number)")
}

closureCaseFunction(a: 5, b: 3) { (number) in      // 사후적 정의
    print("출력") // 파라미터를 반드시 사용하지 않아도 됨  무시해도 된다는 것
}

// 실질적으로 순차적으로 실행됨. 따라서 파라미터로 전달하는 클로저가 기존의 함수 내용이 다 실행되고나서 실행된다고 봐도 무방함

// 이렇게 사후적 정의를 통하여 사용할수 있기 때문에 개발자 활용도가 높음

/*:
 ---
 * 여러가지 예시로 정확하게 이해하기
 ---
 */

let print1 = {
    print("1")
}

let print2 = {
    print("2")
}

let print3 = {
    print("3")
}


// 함수의 정의

func multiClosureFunction(closure1: () -> Void, closure2: () -> Void) {
    closure1()
    closure2()
}





// 함수의 실행

multiClosureFunction(closure1: print1, closure2: print2)

multiClosureFunction(closure1: print2, closure2: print3)


multiClosureFunction(closure1: {
    print("1")
    print("11")
}, closure2: {
    print("2")
})
// 이렇게 사후적으로 클로저를 정의하여 얼마든지 활용 가능함


// 함수의 정의

func performClosure(closure: () -> ()) {
    print("시작")
    closure()
    print("끝")
}



// 함수의 실행

performClosure(closure: {
    print("중간")
})







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
