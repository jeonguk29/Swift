import UIKit


/*:
 ## 클로저의 문법 최적화
 * 클로저는 실제 사용시 읽기 쉽고, 간결한 코드 작성을 위해 축약된 형태의 문법을 제공함
 ---
 */
/**=============================================================================
 [문법 최적화(간소화)]
 - 1) 문맥상에서 파라미터와 리턴밸류 타입 추론(Type Inference)
 - 2) 싱글 익스프레션인 경우(한줄), 리턴을 안 적어도 됨(Implicit Return)
 - 3) 아규먼트 이름을 축약(Shorthand Argements) ===> $0, $1
 - 4) 트레일링 클로저 문법: 함수의 마지막 전달 인자(아규먼트)로 클로저 전달되는 경우, 소괄호를 생략 가능
 ===============================================================================**/

/*:
 ---
 * 1. 트레일링(Trailing) 클로저 - 후행 클로저 문법
 ---
 */
// 1) (클로저를 파라미터로 받는 함수)정의

func closureParamFunction(closure: () -> Void) {
    print("프린트 시작")
    closure()
}




// 2) 함수를 실행할때 클로저 형태로 전달
// 함수의 마지막 전달 인자(아규먼트)로 클로저 전달되는 경우, 소괄호를 생략 가능

closureParamFunction(closure: {         // 우리가 기존에 사용한 사후정의 형태
    print("프린트 종료")
})

closureParamFunction(closure: ) {      // 소괄호를 앞으로 가져오기
    print("프린트 종료")
}

closureParamFunction() {               // 아규먼트 생략가능
    print("프린트 종료")
}


// 소괄호를 아예 생략할 수 있다.
// ==> 아래 형태가 함수를 실행하고 마지막 아규먼트로 클로저를 전달했다는 형태에 익숙해져야함

closureParamFunction {
    print("프린트 종료")
}

// 위에 3가지 형태가 다 후행 클로저 형태인 것임

// 연습

// 1) (함수를 파라미터로 받는 함수)정의

func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}

// tip 자동완성시 클로저 부분에서 엔터치면 자동으로 후행 클로저형태로 만들어줌

// 2) 함수를 실행할때 클로저 형태로 전달

closureCaseFunction(a: 5, b: 2) { number in      // 소괄호가 클로저 앞에서 닫힘
    print("출력할까요? \(number)")                   // + 아규먼트도 생략
}




/*:
 ---
 * 2. 파라미터 및 생략 등의 간소화
 ---
 */
// 함수의 정의

func performClosure(param: (String) -> Int) {
   param("Swift")                 // 현재 반환 void 생략 되었고 단순 실행만 하는 함수임
}



// 문법을 최적화하는 과정

// 1) 타입 추론(Type Inference)

performClosure(param: { (str: String) in
    return str.count                        // 반환 타입 생략가능
})

performClosure(param: { str in              // func performClosure(param: (String) -> Int) 이런식으로
                                            // (클로저를 파라미터로 받는)함수에서 타입을 정의 했기 때문에 매개변수 타입 생략 가능
    return str.count
})


// 2) 한줄인 경우, 리턴을 안 적어도 됨(Implicit Return)

performClosure(param: { str in
    str.count
})


// 3) 아규먼트 이름을 축약(Shorthand Argements)

performClosure(param: {
    $0.count                // $0 아규먼트 첫번째 , $1 아규먼트 두번째....  아규먼트 생략하고 그냥 이걸로 끝내버림
    // 이렇게 쓰면 아규먼트 있는걸 알 수 있으니까 위에 생략을 해버리고 한군데만 쓰기 위함임
})


// 4) 트레일링 클로저

performClosure(param: {
    $0.count
})

performClosure() {
    $0.count
}

performClosure { $0.count } // 결론적으로는 이렇게 까지 줄일수가 있는 것임




/*:
 ---
 * 축약 형태로의 활용
 ---
 */

let closureType1 = { (param) in
    return param % 2 == 0   //  param를 2로 나눌수 있는 건 정수형 밖에 없음 그리고 최종적으로 == 로 비교했을 때 결과는 bool타입임
} // let closureType1: (Int) -> Bool 매개변수 타입과, 리턴 타입 생략 한 것을 알 수 있음

let closureType2 = { $0 % 2 == 0 }
// 한줄이라 리턴 타입 지우고 $0로 매개변수를 생략함




let closureType3 = { (a: Int, b:Int) -> Int in
    return a * b
}

let closureType4: (Int, Int) -> Int = { (a, b) in       // 타입을 다 앞을로 빼고 클로저 사용시 타입을 생략
    return a * b
}

let closureType5: (Int, Int) -> Int = { $0 * $1 } // 타입 명시 필요 * 경우는 더블 타입도 곱할 수 있어서

// let closureType5 = { $0 * $1 } 타입 지우면 에러남


/*:
 ---
 * 클로저 활용의 실제 활용 예시
 ---
 */
// ⭐️ 현재 여기서는 형태에만 주목하면됨 (앱을 만들어 보고 보면 이해됨)


// 1) 첫번째 예시

//URLSession(configuration: .default)
//    .dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)



//URLSession(configuration: .default).dataTask(with: URL(string: "https://주소")!) { (data, response, error) in
//    // 데이터 처리하는 코드
//}





// 2) 두번째 예시



//Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: <#T##(Timer) -> Void#>)

Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
    print("0.5초뒤에 출력하기")
}





// 3) 세번째 예시

class ViewController: UIViewController {
    
    
}

let vc = ViewController()


//vc.dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)

vc.dismiss(animated: true) {
    print("화면을 닫는 것을 완료했습니다.")
}



//:> 콜백 함수: 함수를 실행하면서, 파라미터로 전달하는 함수
// 주로 함수가 실행된 결과는 콜백 함수로 전달받아 처리하기 때문에



/*:
 ---
 * 멀티플 트레일링 클로저 - Swift 5.3
 ---
 */
// 여러개의 함수를 파라미터로 사용할때

func multipleClosure(first: () -> (), second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}



// 기존 방식에서는 마지막 클로저만 트레일링 클로저로 쓸 수 있었음
// (클로저의 경계에서 코드가 헷갈릴 가능성이 있었음)

multipleClosure(first: {
    print("1")
}, second: {
    print("2")
}) {
    print("3")
}



multipleClosure {
    print("mutil-1")
} second: {
    print("mutil-2")
} third: {
    print("mutil-3")
}



// 아규먼트 레이블을 생략하는 경우

func multipleClosure2(first: () -> (), _ second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}


// 아큐먼트 레이블을 생략하지 못함

multipleClosure2 {
    print("1")
} _: {
    print("2")
} third: {
    print("3")
}





// 멀티 트레일링 클로저 - 실사용 예시

//UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)



UIView.animate(withDuration: <#T##TimeInterval#>) {
    <#code#>
} completion: { (<#Bool#>) in
    <#code#>
}







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
