//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: # 동시큐에서 직렬큐로 보내기
//: ### Thread-safe하지 않을때, 처리하는 방법
// 배열은 여러쓰레드에서 동시에 접근하면 문제가 생길 수 있다.


var array = [String]()

let serialQueue = DispatchQueue(label: "serial")        // 직렬큐 생성


for i in 1...20 {
    DispatchQueue.global().async {
        print("\(i)")
        //array.append("\(i)")    //  <===== 동시큐에서 실행하면 동시다발적으로 배열의 메모리에 접근
        /*
         아래 코드 주석하고 위코드로 실행시
         숫자 몇개 빠진걸 확인 할 수 있는게 배열의 주소는 하나임 근데 2번 스레드에서 3이라는 숫자 추가하려고 하는데
         3번 스레드에서도 그자리에 8이라는 숫자 추가하려고해서 밀려버려 빠진 것임 그래서 Thread-safe하지 않은 상황이 나오는 것임
         */
        
        serialQueue.async {        // 올바른 처리 ⭐️
            array.append("\(i)")
        }                           // 직렬큐를 하나 만들어서 비동기적으로 다른 쓰레드에서 처리된걸 순차적으로 들어오는데로 하나하나 추가하기 때문에
    }                               // 20까지 빠지는 숫자 없이 처리 할 수가 있음
}
// 즉 빠른작업을 동시큐로 보냈다가 다시 직렬큐로 보내는 작업으로 처리하면 동시 접근문제를 해결할수 있음 즉 Thread-safe하게 구현 가능함



// 5초후에 배열 확인하고 싶은 코드 일뿐...

// asyncAfter 비동기적으로 메인 쓰레드에서 실행할건데 몇초후에 실행해라는 코드임
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    print(array)
    //PlaygroundPage.current.finishExecution()
}



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
