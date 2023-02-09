//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


// 동기적인 함수의 정의

func task1() {
    print("Task 1 시작")
    sleep(3)
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    sleep(2)
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    sleep(1)
    print("Task 3 완료★")
}


//: # 직렬(Serial)큐 VS 동시큐(Concurrent)

//: ### Serial 직렬큐
let serialQueue = DispatchQueue(label: "com.inflearn.serial")
// label: "com.inflearn.serial" 개발자가 이름 마음대로 적으면 직렬큐가 되는것임


serialQueue.async {
    task1()
}

serialQueue.async {
    task2()
}

serialQueue.async {
    task3()
}


// 비동기적으로 보내더라도, 순서대로 출력
// 1번 쓰레드가 아니긴 하지만 2번 쓰레드에 보낼탠데 순서도로 작업을 보내기 때문임

//: ### Concurrent 동시큐
let concurrentQueue = DispatchQueue.global() // 이건 동시큐가 되는 것임
// 상수로 담은 다음 동시큐 처리

concurrentQueue.async {
    task1()
}

concurrentQueue.async {
    task2()
}

concurrentQueue.async {
    task3()
}


// 순서대로 안나옴 일을 여러 쓰레드에 보내고 동시 처리해서







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
