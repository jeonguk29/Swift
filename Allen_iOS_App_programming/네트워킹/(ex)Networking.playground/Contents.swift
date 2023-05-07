import UIKit


/*:
 # CRUD 네트워킹
 */
/*:
 ## GET메서드(서버에서 데이터 읽어오기)
 * (예) 인스타그램 - 내가 팔로잉하는 사람들의 게시글 보기
 ---
 */
/*
 HTTP 통신을 하기 위해 아래 코드를 다 외울 필요가 없음
 GET 요청을 보내기 위해 복사하고 주소만 바꿔서 사용하면 되는 것임
 
 패턴은 다 똑같음
 1. URL구조체 만들기
 2. URL요청 생성
 3. 요청을 가지고 작업세션시작
 4. 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 (응답이 있을 경우)
 */
func getMethod() {

    // URL구조체 만들기
    guard let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101")
    // 문자열을 가지고 URL 구조체를 만드는데 오류가 날 수 있기 때문에 옵셔널 바인딩을 해주는 것임
      
    else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url) // 서버에다가 HTTP 프로토콜을 통해 통신 할 수 있는 요청 메세지를 날려야 한다고 했음 이것을 만드는 방법임
    request.httpMethod = "GET" // 요청 메서드 정하기
    
    
    // 요청을 가지고 작업세션시작
    // 싱글톤 패턴으로 세션을 생성 URLSession은 어떤 브라우저에 하나의 탭이라고 생각하면 됨
    /*
     위에서 생성한 URL을 넣어 작업을 할 수도 있고, request를 넣어 작업을 할 수도 있음
     그 외 컴플리션 헨들러 코드는 동일함
     
    URLSession.shared.dataTask(with: url) { { data, response, error in
        // 일반적으로 url을 가지고 요청할 수 있는 것은 GET 요청방식이 기본으로 전제로 깔린 것임
        // 일반적으로 이 메서드를 사용할때는 GET 요청을 한다고 생각하자
    }
        
        
    URLSession.shared.dataTask(with: request) { data, response, error in
            // 위에서 request를 정의해서 사용하는게 정석적인 방법임
            // 실행이 되면 그 결과 (JSON 데이터를) data, response, error 에 전달을하는 것임
    }
    */
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감 (타입 케스팅을 한번 해줌)
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }

        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self)) // 데이터 형식을 우리가 볼 수 있는 문자열 형태로 변형


    }.resume()     // 시작
    // URLSession 같은게 멈춤 상태에서 시작하기때문에 시작 까지 해주는 것임
}


getMethod()





/*:
 ## POST메서드(서버에 내가 원하는 new데이터 업로드하기)
 * (예) 인스타그램 - 나의 포스트 올리기 / 다른 사람의 게시물에 댓글 달기 / 서비스 가입하기
 ---
 */

/*
 POST메서드는 당연히 GET메서드 보다 코드가 좀더 길고 복잡할 수 밖에 없음 실제로 서버에 정보를 보내기 때문임
 1. 업로드할 모델을 만듬 (클래스, 구조체)
 2. 실제 업로드할 (데이터)인스턴스 생성
 3. 모델을 JSON data 형태로 변환 (서버와 HTTP 통신 하기 위한 데이터 형식으로 변환 메세지 바디에 넣어줄것임)
 4. URL요청 생성
 5. 요청을 가지고 세션 작업시작
 6. 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 (응답이 있을 경우)
 */
func postMethod() {
    
    guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/create") else {
        print("Error: cannot create URL")
        return
    }
    
    // 업로드할 모델(형태)
    struct UploadData: Codable {
        let name: String
        let salary: String
        let age: String
    }
    
    // 실제 업로드할 (데이터)인스턴스 생성
    let uploadDataModel = UploadData(name: "Jack", salary: "3540", age: "23")
    
    // 모델을 JSON data 형태로 변환
    // 위에서 실제 업로드할 인스턴스를 이렇게 encode메서드에 만들면 웹상의 데이터 형태로 만들어줌
    // 이 데이터를 HTTP 바디에 넣어줄것임
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return
        /*
         JSONDecoder로 decode코드는 웹상에 있는 데이터를 우리의 클래스나, 구조체로 바꾸기 위해 사용 하는 것이고
         JSONEncoder의 encode(메서드)코드는 우리의 클래스나, 구조체를 반대로 데이터로 바꾸는 것임
         */
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // 요청 셋팅을 할때 아래 두줄 처럼 이러한 헤더 정보를 추가해달라고 하는 서버요청이 있기 때문에 가끔씩 이러한 코드들이 필요함
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // 요청타입 JSON
    request.setValue("application/json", forHTTPHeaderField: "Accept") // 응답타입 JSON
    
    // HTTP 바디를 셋팅해주는 곳 여기가 본문임
    request.httpBody = jsonData
    
    
    // 요청을 가지고 세션 작업시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling POST")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))
        
    }.resume()   // 시작
}

postMethod()








/*:
 ## PUT메서드(서버에 현존하는 데이터 업데이트하기)
 * (예) 인스타그램 - 나의 포스트 수정하기 / 다른 사람 게시물의 좋아요 누르기 / 나의 정보 수정
 ---
 */

func putMethod() {
    guard let url = URL(string: "https://reqres.in/api/users/2") else {
        print("Error: cannot create URL")
        return
    }
    
    // 업로드할 모델(형태)
    struct UploadData: Codable {
        let name: String
        let job: String
    }
    
    // 실제 업로드할 (데이터)인스턴스 생성
    let uploadDataModel = UploadData(name: "Nicole", job: "iOS Developer")
    
    // 모델을 JSON data 형태로 변환
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    // 요청을 가지고 작업세션시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling PUT")
            print(error!)
            return
        }
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))
        
    }.resume()
}

putMethod()

/*:
 ## DELETE메서드(서버에 현존하는 데이터 삭제하기)
 * (예) 인스타그램 - 나의 포스트 삭제하기
 ---
 */

// 지워주기만 해서 조금 간단한 형태임
func deleteMethod() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    // 요청을 가지고 작업세션시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling DELETE")
            print(error!)
            return
        }
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))
        
    }.resume()
}

deleteMethod()


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
