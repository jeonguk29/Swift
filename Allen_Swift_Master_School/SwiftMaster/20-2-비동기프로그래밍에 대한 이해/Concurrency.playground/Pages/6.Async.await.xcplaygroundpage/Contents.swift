//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


//: ### 작업을 오랫동안 실행하는 비동기 함수가 있다고 가정

func longtimePrint(completion: @escaping (Int) -> Void) {
    DispatchQueue.global().async {  // 기존에는 오래걸리는 함수 안에 디스패치큐를 넣어서 비동기 처리를 했어야 했음 그리고 끝나는 시점에 데이터를
        print("프린트 - 1")            // 전달을 받는다면 클로저를 통해서 전달 받고 처리했음
        sleep(1)
        print("프린트 - 2")
        sleep(1)
        print("프린트 - 3")
        sleep(1)
        print("프린트 - 4")
        sleep(1)
        print("프린트 - 5")
        completion(7)
    }
}



//: # Async/await의 도입
//: ### Swift 5.5버전 이후 ~
//:> 콜백함수 처리방식의 단점
// 여러개의 비동기함수를 이어서 처리할때, 코드의 처리가 불편
// 비동기함수의 일이 종료되는 시점을 연결하기 위해, 끊임없는 콜백함수의 연결이 필요
// 코드는 계속 들여쓰기.. 들여쓰기.. 들여쓰기..



func linkedPrint(completion: @escaping (Int) -> Void) {
    longtimePrint { num in
        // 코드처리
        longtimePrint { num in
            // 코드처리
            longtimePrint { num in
                // 코드처리
                longtimePrint { num in
                    // 코드처리
                    completion(num)    // 모든 비동기함수의 종료시점을 알려줌
                }
            }
        }
    }
}



//:> Async/await 방식의 도입 / Swift 5.5 ~
// 콜백함수를 계속 들여쓰기 할 필요없이 반환시점을 기다릴수 있어, 깔끔한 코드의 처리가 가능



// Async/await 함수의 설계
// 내부에 따로 DispatchQueue로 보낼 필요는 없음

//func longtimeAsyncAwait() async -> Int {  // async 를 붙이면 디스패치 큐 붙일필요도 없이 비동기 처리를 해준 다는 것임
//    print("프린트 - 1")
//    sleep(1)
//    print("프린트 - 2")
//    sleep(1)
//    print("프린트 - 3")
//    sleep(1)
//    print("프린트 - 4")
//    sleep(1)
//    print("프린트 - 5")
//    return 7
//}



// Async/await 함수의 사용

//func linkedPrint2() async -> Int {    // async를 사용한 함수는 이런식으로
//    _ = await longtimeAsyncAwait() // await 를 할 수 있다는 것임 이게 오리걸리는 함수지만 이 작업이 끝날때 까지 기다릴 수 있는 코드로 만든 것임
//    _ = await longtimeAsyncAwait()
//    _ = await longtimeAsyncAwait()
//    _ = await longtimeAsyncAwait()
//    return 7
//}



/*
 핵심은 클로저를 통해서 끝나는 시점을 알아챌수 있도록 전달하는 코드를 리턴형으로 설계 할 수 있다는 것임 그대신
 반드시 async 키워드를 붙여야 하고 실행하는 쪽에서는 await 키워드를 붙여야함 이게 핵심임
 비동기적으로 오래걸리긴 하지만 코드를 깔끔하게 정리된 형태로 볼 수 있다는 것이 장점임
 
 즉 이제 비동기 처리를 할때 다른 쓰레드에 작업을 넘김과 동시에 기다리지 않았던것을 기다리게 설계를 한 것임
 즉 잠시 처리될때 까지 기다리고 cpu은 다른일처리를 하고옴 리턴이 될때까지 
 */



sleep(7)
PlaygroundPage.current.finishExecution()


//참고 https://github.com/apple/swift-evolution/blob/main/proposals/0296-async-await.md

//: [Next](@next)
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
