//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # UI업데이트는 메인쓰레드에서
//: ### 유저인터페이스(즉, 화면)와 관련된 작업은 메인쓰레드에서 진행해야 함

var imageView: UIImageView? = nil


let url = URL(string: "https://bit.ly/32ps0DI")!


// URL세션은 내부적으로 비동기로 처리된 함수임.
URLSession.shared.dataTask(with: url) { (data, response, error) in
//    DispatchQueue.global().async { 즉 내부적으로 이렇게 이 블럭 안해서 처리 된다고 생각하면 됨 다시말해 URLSession은 메인쓰레드에서 실행 x

    // 뭔가 이미지 관련된 주소인데 처리를 다하면 (data, response, error) 형태로 반환을 해서 클로저에 줄것임
    
    if error != nil{
        print("에러있음")
    }
    
    guard let imageData = data else { return }
    
    // 즉, 데이터를 가지고 이미지로 변형하는 코드
    let photoImage = UIImage(data: imageData)
    
    // 🎾 이미지 표시는 DispatchQueue.main에서 🎾
    DispatchQueue.main.async {
        imageView?.image = photoImage   // 즉 이미지 표시 같은 UI작업은 반드시 메인큐에서 해줘야함
    }
    // 다시말해 비동기 처리를 할때 3가지 큐가 있었음 그 큐에서 작업을 하다가 이미지 표시 같은 UI 작업을 만나면 반드시 메인큐로 감쌓아서
    // 즉 메인큐에 비동기 처리를 해줘야함 == 결론적으로 메인큐로 보내줘야함 메인큐(메인쓰레드)가 화면을 그리는 역할을 하니까 
    
    
}.resume()





//:> UI와 관련된 일은 다시 메인쓰레드로 보내야 함

DispatchQueue.global().async {
    
    // 비동기적인 작업들 ===> 네트워크 통신 (데이터 다운로드)
    
    DispatchQueue.main.async {
        // UI와 관련된 작업은 
    }
}










sleep(4)

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
