import UIKit

/*:
 ## 네트워킹 코드에서 Result타입
 * 네트워킹 코드에서의 활용
 ---
 */

enum NetworkError: Error {
    case someError
}


//:> Result 타입 사용하기 전
// 튜플타입을 활용, 데이터 전달

func performRequest(with url: String, completion: @escaping (Data?, NetworkError?) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!)                 // 에러가 발생했음을 출력
            completion(nil, .someError)   // 에러가 발생했으니, nil 전달
            return
        }
        
        guard let safeData = data else {
            completion(nil, .someError)   // 안전하게 옵셔널 바인딩을 하지 못했으니, 데이터는 nil 전달
            return
        }
    
        completion(safeData, nil)
        
    }.resume()
}



performRequest(with: "주소") { data, error in
    // 데이터를 받아서 처리
    if error != nil {
        print(error!)
    }
    
    // 데이터 처리 관련 코드
    
}



//:> Result 타입 사용 후
// 파라미터 두개가 아니라 리절트 타입을 넣는 것임
func performRequest2(with urlString: String, completion: @escaping (Result<Data,NetworkError>) -> Void) {
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!)                     // 에러가 발생했음을 출력
            completion(.failure(.someError))  // 실패 케이스 전달
            //completion(Result.failure(NetworkError.someError))      // 위 코드를 풀로 다 적었을때
            // 이코드는 리절트 타입의 실패를 전달하는 거고 실패일 경우가 열거형이라 열거형 내부의 에러 케이스를 던지는 것임
            return
        }
        
        guard let safeData = data else {
            completion(.failure(.someError))   // 실패 케이스 전달
            
            //completion(Result.failure(NetworkError.someError))      // 위 코드를 풀로 다 적었을때
            // 이코드는 리절트 타입의 실패를 전달하는 거고 실패일 경우가 열거형이라 열거형 내부의 에러 케이스를 던지는 것임
            
            return
        }
    
        completion(.success(safeData))      // 성공 케이스 전달
        //completion(Result.success(safeData))      // 위 코드를 풀로 다 적었을때 데이터를 전달
        // 이코드는 리절트 타입의 성공를 전달하는 거고 성공일 경우에는 데이터를 던짐
        // 이렇게 줄여서 사용할 수 있는 이유는 처음 함수 정의시 completion: @escaping (Result<Data,NetworkError>
        // 각각의 성공 실패일 경우 어떤이름의 열거형이 들어간다고 명시 해줬기 때문임
        
    }.resume()
}



// performRequest2(with: <#T##String#>, completion: <#T##(Result<Data, NetworkError>) -> Void#>)
// 함수 실행시 클로저를 전달할때 결과 타입이 사용되었다는 걸 알수있음 여기서 이제 파라미터 하나로 바뀜
// result 이름이라는 변수안에 성공 실패 경우가 모두 들어가기 때문임

performRequest2(with: "주소") { result in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let data):
        // 데이터 처리 관련 코드
        break
    }
}

/*
 성공 실패일 경우에 연관 값을 던지기 때문에 내부적으로 두가지 경우에 따라 좀더 쉬운 처리를 할 수 있게되는 것임
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
