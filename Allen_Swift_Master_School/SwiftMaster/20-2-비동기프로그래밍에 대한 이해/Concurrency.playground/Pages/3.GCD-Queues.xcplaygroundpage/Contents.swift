//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/*
 iOS에서 큐에 종류는 DispatchQueue(GCD) / OperationQueue 이렇게 두가지가 있다고 했는데
 그중 디스패치큐를 뜯어 보겠음
 1. main큐 => DispatchQueue.main : 메인큐 = 메인쓰레드 (1번쓰레드): 직렬(Serial) 
 
 2. global큐 => DispatchQueue.global(qos: ) : 6가지 Qos (작업에 따라 Qos상승가능)
 (시스템이 우선순위에 따라 더 많은 쓰레드를 배치하고, 배터 리를 더 집중해서 사용하도록 함) 개발자가 정하는 것임 :
 Concurrent (동시) 처리 할건데 우선순위에 따라 더 많은 쓰레드를 배치하고 배터 리를 더 집중해서 사용하게 하려고 할때 선택적으로 상황에 맞게 골라서 해당 큐 사용
 
 // 즉 메인 큐에서 처리하다가 큐의 서비스품질(Quality Of Service)에 따라 쓰레드 (개수), 배터리 집중사용에 대한 고려사항이 있을때
 global에 6가지 종류중 골라서 메인큐 작업을 각각의 global큐 종류에 맞게 작업을 할당 해주는것임
 
 3. custom(프라이빗)큐 => DispatchQueue(label: “...”) : Qos추론 / Qos설정가능 : 디폴트 (Serial) 
    둘다가능 (attributes로 설정)
 
 요약 main큐에서 작업하다가 작업을 비동기 동시 처리할때 그 해당 작업의 서비스품질에 따라 global 큐에서 6가지중 원하는 걸 사용하면 되는 것
 (더 많은 쓰레드를 배치하고, 배터 리를 더 집중해서 사용하도록 함) 혹은 비동기 처리시 직렬처리 하고 싶을때 custom(프라이빗)큐 이용해서 사용하면 됨
 둘다가능 (attributes로 설정)하다는 것만 알면 됨
 */
//: # 큐(Queue/대기열)의 종류
//: ### 1)메인큐
//메인큐 = 메인쓰레드("쓰레드1번"을 의미), 한개뿐이고 Serial큐

let mainQueue = DispatchQueue.main

//mainQueue.async {
//    <#code#>
//}
// 이렇게하고 안에 코드를 입력하면 당연히 1번 쓰레드에서 일을 시키게 되는 것임 물론 이렇게 쓸필요가 없음
// 다른 쓰레드에서 실행하지 않는한 무조건 메인쓰레드에서 실행하기 때문임 요게 메인 큐다 정도만 알고 넘어가자

//: ### 2) 글로벌큐
// 6가지의 Qos를 가지고 있는 글로벌(전역) 대기열

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let defaultQueue = DispatchQueue.global()  // 디폴트 글로벌큐 == DispatchQueue.global(qos: .default)
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)
let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)

// 서비스 품질에 따라서 6개의 종류가 있음 디폴트 큐 같은 경우는 중간 정도에 위치되어 있음 위가 더 높은거 아래가 낮은 순서임
// 다 외울 필요 절대 없고 디폴트 글로벌 큐만 외워도 됨 필요한 경우 찾아서 쓰면 된다 찾아 쓸일도 크게 없을 것임





//: ### 3) 프라이빗(커스텀)큐
//기본적인 설정은 Serial, 다만 Concurrent설정도 가능


let privateQueue = DispatchQueue(label: "com.inflearn.serial")

/*
 애는 직접적으로 개발자가 만들수 있는 큐이기 때문에 아래와 같이 여러가지 설정들을 해줄수 가 있음
DispatchQueue(label: <#T##String#>, qos: <#T##DispatchQoS#> ,attributes: <#T##DispatchQueue.Attributes#>, autoreleaseFrequency: <#T##DispatchQueue.AutoreleaseFrequency#>, target: <#T##DispatchQueue?#>)

 추가적으로 ,attributes: .concurrent 로 해주면 동시큐로 만들 수도 있음
 
 즉 직접적으로 개발자가 큐를 만드는데 이런경우에는 여러개의 쓰레드를 사용할 수 있도록 동시큐로 만들수 있다는걸 알자 드물긴 함
 일반적으로 프라이빗 큐는 직렬큐를 사용하기 위함임
*/

sleep(5)

PlaygroundPage.current.finishExecution()

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
