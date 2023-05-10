//
//  NetworkingManager.swift
//  MusicApp
//
//  Created by 정정욱 on 2023/05/10.
//

import Foundation
/*
 ⭐️ 일반적인 이런 네트워킹 메니저는 싱글톤 패턴으로 만듬
 
 하나의 화면에서만 접근 하면 싱글톤으로 만들 필요가 없긴 하지만
 여러 뷰 컨트롤러가 사용하는데 파일을 각각 만드는 것 보다 싱글톤으로 공유하게 사용하는게 훨씬 효과적임
 
 */
class NetworkingManager {
    
    static let shared = NetworkingManager()
    // 자기 자신을 생성해서 타입 저장속성에 할당을 하는 것임 그럼 이 변수는 데이터 영역에 존재하고
    // 실제 싱글톤은 힙 영역에 존재할 것임 하나만
    
    private init() {} // 다른 네트워킹 메니져 생성하지 말라고 생성자 막아줘야함
    
    func getMethod(completionHandler: @escaping ([Music]?) -> Void){

        // URL구조체 만들기
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=hippop")
        // 문자열을 가지고 URL 구조체를 만드는데 오류가 날 수 있기 때문에 옵셔널 바인딩을 해주는 것임
          
        else {
            print("Error: cannot create URL")
            completionHandler(nil) // ⭐️ 에러가나면 콜백함수에 nil을 넣고 호출함
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url) // 서버에다가 HTTP 프로토콜을 통해 통신 할 수 있는 요청 메세지를 날려야 한다고 했음 이것을 만드는 방법임
        request.httpMethod = "GET" // 요청 메서드 정하기
        
        
        // 요청을 가지고 작업세션시작
        // ⭐️ 비동기적으로 실행되기 때문에 바로 다음 코드가 잇다면 먼저 실행 되는걸 항상 주의해야함
        // 기본적으로 네트워킹 작업은 코드가 비동기적으로 처리 되어있다는 걸 알고있어야함
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling GET")
                completionHandler(nil) // ⭐️ 에러가나면 콜백함수에 nil을 넣고 호출함
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                completionHandler(nil) // ⭐️ 에러가나면 콜백함수에 nil을 넣고 호출함
                return
            }
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감 (타입 케스팅을 한번 해줌)
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completionHandler(nil) // ⭐️ 에러가나면 콜백함수에 nil을 넣고 호출함
                return
            }

         
            do {
                let decoder = JSONDecoder()
                let MusicData = try decoder.decode(MusicData.self, from: safeData)

                completionHandler(MusicData.results) // ⭐️ 에러가 아니면 배열을 전달
                return // 리턴을 함으로써 이 getMethod를 끝내는거라 넣어줘야함
            } catch{
                
            }
            
        }.resume()     // 시작

    }


    //getMethod(completionHandler: <#T##([Music]?) -> Void#>)
    // 배열을 잘 받아오면 아래 코드를 실행
//    getMethod { musicArray in
//        guard let array = musicArray else {return} // 여기 리턴은 현제 이 클로저를 벗어나겠다는 뜻
//        dump(array)
//    }

}
