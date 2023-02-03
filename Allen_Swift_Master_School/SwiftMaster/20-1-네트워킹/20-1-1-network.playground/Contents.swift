import UIKit


/*:
 # Part20 - 1 - 네트워킹(Networking)
 */
/*:
 ## 네트워크 통신(서버와의 통신)의 기초
 * 참고 URL
 ---
 */
// 영화 진흥위원회 오픈 API
// https://www.kobis.or.kr/kobisopenapi/homepg/main/main.do


// 요청주소
// http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json


// 키: 각자의 것으로 발급
// 4d5d8aaff18ee7542b218db4a2632b6b

// 요청 예시
// http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=KEYVALUE&targetDt=20210201

/* 2023-02-03 최신
"http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
 여가까지가 주소
 
 ?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101
 
 ? 부터는 쿼리임 쿼리 파라미터는 &로 연결하기 때문에 순서 바꿔줘도 됨
 ?targetDt=20120101&key=4d5d8aaff18ee7542b218db4a2632b6b&multiMovieYn=N
 끝에 파라미터는 다양성 영화 항목을 의미함
 
 그래서 get방식인 경우 쿼리를 붙일수 있다고 했으니 요청서버주소 url + 쿼리는 아래와 같은 형태
 "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20120101&key=4d5d8aaff18ee7542b218db4a2632b6b"
 */

// JSON데이터를 스위프트 코드로 변환
// https://app.quicktype.io/


//:> session(세션) 영단어 뜻: 기간 / 시간
// 세션 ==> 연결 상태 유지 ⭐️
// 일정 시간동안 같은 브라우저(사용자)로부터 들어오는 연결 상태를 일정하게 유지시키는 기술(상태)

/*:
 ---
 * iOS에서의 네트워킹의 기본
 ---
 */
// 0. URL주소 - 문자열로
let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20120101&key=4d5d8aaff18ee7542b218db4a2632b6b"


// 1. URL 구조체 만들기
let url = URL(string: movieURL)!
        // 서버와 통신하기 위해 만든 URL구조체를 활용하여 변환 현재 문자열 값을 생성자에넣어서 구조체 생성하는 코드
        // url은 URL? 타입임 url이 잘못된 주소일때 nil 반환을 위함임 그래서 옵셔널 바인딩을 하여 넣을 수도 있지만
        // 확실하기 때문에 !를 붙여줌

// 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할)
let session = URLSession.shared // 싱글톤 객체를 생성   :   싱글톤 유일하게 메모리에서 객체를 여러개를 찍어내려는게 아니고
    // 객체가 메모리에 딱 하나만 존재하도록 생성하도록 하는 것 네트워크 통신 하는녀석 딱 하나만 만든 것임
    // URLSession.shared                    보통 URLSession 생성할때 이렇게 2가지 형태를 많이 사용
    //URLSession(configuration: .default)


// 3. 세션에 (일시정지 상태로)작업 부여
//session.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
// 클로저 형태로 사용       3가지 파라미터를 받는데 다 옵셔널임 데이터가 있을수도 없을 수도, 응답이 있을수도 없을 수도, 에러가 있을 수도 없을 수도 있다.


// 우리가 만든 url 주소로 뭔가를 실행 이후 뭔가 네트워크 통신을 다한다음에 그결과를 data, response, error로 주는 것임
// 대략적으로 http메세지를 날리고 그다음에 서버에서주는 http프로코콜을 해석을 한다음에 json데이터로 올거임 그결과를 data, response, error 이 세가지 메세지를 주는 것임

let task = session.dataTask(with: url) { (data, response, error) in
    if error != nil {   // 관습적으로 에러가 있는지 없는지 먼저 확인 에러 발생시 빨리 종료 시키기 위함
        print(error!)   // 뭔가 에러가 발생 했다면 error 한번 출력
        return
    }
    /*
     guard error == nil else {
        print(error!)
        return
     }
     */
    
    guard let safeData = data else {    // nil아니라면 아래 코드로 이동
        return
    }
    
    // 데이터를 그냥 한번 출력해보기
    print(String(decoding: safeData, as: UTF8.self))      // 데이터를 문자열로 출력하는 코드
    
   // dump(parseJSON1(safeData)!)
    
    
}

// 4.작업시작
task.resume()   // 일시정지된 상태로 작업이 시작하기 때문

// 일반적으로 task 와 같은 변수에 넣고 엔터명령과 같은 메서드를 통하여 실행함

/* 이와 같은 형태로도 많이 실행함
 
 session.dataTask(with: url) { (data, response, error) in
     if error != nil {
         print(error!)
         return
     }
     
     guard let safeData = data else {
         return
     }
     
     // 데이터를 그냥 한번 출력해보기
     print(String(decoding: safeData, as: UTF8.self))
     
     dump(parseJSON1(safeData)!)
     
     
 }.resume()
 
 
 // session 변수도 따로 만들지 않고 통으로 실행 하는 코드도 많이 보임
 URLSession.shared.dataTask(with: url) { (data, response, error) in
 if error != nil {
     print(error!)
     return
 }
 
 guard let safeData = data else {
     return
 }
 
 // 데이터를 그냥 한번 출력해보기
 print(String(decoding: safeData, as: UTF8.self))
 
 dump(parseJSON1(safeData)!)
 
 
}.resume()
 
 */

// ⭐️ 비동기적으로 동작함

/*
 정리
 
 iOS 데이터 요청의 4단계
 1. URL 구조체
 2. URLSession  : 브라우저 키고
 3. dataTask    : url 입력        단계에서 아래와 같은 http 메세지를 보내는 것임
 rest api 란  http에 요청을 보낼때 어떤 uri를 사용할지 어떤 메소드를 사용할지에 대한 약속 규칙 형식

 GET /movielists?name=yourname HTTP/1.1
 Host: www.somemovie.com
 이런 http 요청에 대한 응답으로 클로저 형태로 옴 (JSON) => 가공해서 우리가 사용하면 됨
 
 4. 시작(resume) : 엔터
 
 
---------------------------------------------------------
 
 // 0. URL주소 - 문자열로
 let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20120101&key="

 let key = "4d5d8aaff18ee7542b218db4a2632b6b"

 // 1. URL 구조체 만들기
 let url = URL(string: movieURL + key)!             이런식으로 key를 상수로 만들어 사용 할 수도 있음
 나중에 다른 서버와 동신할때 key값만 따로 바꿔 넣어주면 됨
 */



// 받아온 데이터를 우리가 쓰기 좋게 변환하는 과정 (분석) ======================================

// 현재의 형태
func parseJSON1(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {
        // 스위프트5
        // 자동으로 원하는 클래스/구조체 형태로 분석
        // JSONDecoder
        let decoder = JSONDecoder()
        
        let decodedData = try decoder.decode(MovieData.self, from: movieData)

        return decodedData.boxOfficeResult.dailyBoxOfficeList
        
    } catch {
        
        return nil
    }
    
}




// 예전의 형태
func parseJSON2(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {
        
        var movieLists = [DailyBoxOfficeList]()
        
        // 스위프트4 버전까지
        // 딕셔너리 형태로 분석
        // JSONSerialization
        if let json = try JSONSerialization.jsonObject(with: movieData) as? [String: Any] {
            if let boxOfficeResult = json["boxOfficeResult"] as? [String: Any] {
                if let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"] as? [[String: Any]] {
                    
                    for item in dailyBoxOfficeList {
                        let rank = item["rank"] as! String
                        let movieNm = item["movieNm"] as! String
                        let audiCnt = item["audiCnt"] as! String
                        let audiAcc = item["audiAcc"] as! String
                        let openDt = item["openDt"] as! String
                        
                        // 하나씩 인스턴스 만들어서 배열에 append
                        let movie = DailyBoxOfficeList(rank: rank, movieNm: movieNm, audiCnt: audiCnt, audiAcc: audiAcc, openDt: openDt)

                        
                        movieLists.append(movie)
                    }

                    return movieLists

                }
            }
        }

        return nil
        
    } catch {
        
        return nil
    }
    
}




// 서버에서 주는 데이터의 형태 ====================================================

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
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
