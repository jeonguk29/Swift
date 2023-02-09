//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/*
 네트워크 작업같은 것을 비동기로 처리 할때 ex 사진받아오기 등
 결국 비동기작업이 명확하게 끝나는 시점을 알고, 어떤 작업을 할 필요가 있음
 사진을 네트워크를 통해 받아오는걸 처리하면 뭔가 비동기 작업 시킨걸 처리를 해줘야함 메인에 쓰레드에 줘서 앱 화면에 뛰우던가
 하지만 그럴때 함수를 이용한다고 가정하에 올바른 콜백함수 즉 completionHandler 컴플리션 핸들러를 사용하여 값을 처리해줘야함
 리턴키워드를 통해 메인쓰레드에서 값처리 하면 안됨
 
 다시말해 우리는 다른 쓰레드에서 작업을 처리할때 함수를 리턴으로 설계하면 안됨
 콜백함수(클로저)를 통해서 작업이 끝나는 시점에 대한 결과를 받아야한다 !! 이걸 기억하자
 */
//: # 올바른 비동기함수의 설계
//: ### 리턴(return)이 아닌 콜백함수를 통해, 끝나는 시점을 알려줘야 한다.

//:> 함수(메서드)를 아래처럼 설계하면 절대 안된다.
func getImages(with urlString: String) -> UIImage? {
    
    let url = URL(string: urlString)! // 메인 쓰레디그 1번 읽고
    
    var photoImage: UIImage? = nil      // 2번 읽고
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in // 3번 읽는 순간 다음 코드로 감 기다리지 않음
        if error != nil {
            print("에러있음: \(error!)")
        }
        // 옵셔널 바인딩
        guard let imageData = data else { return }
        
        // 데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        
    }.resume()

    
    return photoImage    // 항상 nil 이 나옴    : 4번 읽음
}
//  URLSession 자체가 비동기적으로 동작하기 때문임



getImages(with: "https://bit.ly/32ps0DI")    // 무조건 nil로 리턴함 ⭐️






//:> 올바른 함수(메서드)의 설계 - 콜백함수의 사용법
func properlyGetImages(with urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        // (UIImage?) 형태로 받고 싶으니까 클로저 형태로 설계를 해야함 일반적으로 이런 파라미터를  completionHandler 컴플리션 핸들러 라고 말함
    
    let url = URL(string: urlString)!
    
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }
        // 옵셔널 바인딩
        guard let imageData = data else { return }
        
        // 데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        
        completionHandler(photoImage)
        
    }.resume()
    
}

// properlyGetImages(with: <#T##String#>, completionHandler: <#T##(UIImage?) -> Void#>)
// 즉 뭔가 비동기적 처리를 실행시킨 다음에 내부적으로 처리가 다끝나면 사후적으로 그 결과 UIImage?를 받아서 클로저로 실행하겠다는 것임
// completionHandler의 UIImage?는 내부의 결과를 전달 받는 것임
// 즉 뭔가 비동기적 처리의 작업이 끝남을 클로저를 통해 알려줘야(처리) 한다는 것

// 올바르게 설계한 함수 실행
properlyGetImages(with: "https://bit.ly/32ps0DI") { (image) in
    
    // 처리 관련 코드 넣는 곳...
    
    DispatchQueue.main.async {      // 다시 메인 쓰레드로 보내는 코드를 작성하면 됨
        // UI관련작업의 처리는 여기서
    }
    
    // 콜백이니까 결국 이 코드를 실행 할것임 그때 메인 쓰레드로 보낼게 있으면 보내고 처리할게 있으면 처리하면 됨
}



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
