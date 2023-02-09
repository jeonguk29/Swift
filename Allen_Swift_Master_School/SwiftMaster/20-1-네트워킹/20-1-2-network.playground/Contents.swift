import UIKit

/*:
 ## 네트워크 통신(서버와의 통신)의 기초
 * 요청(Request) ➡︎ 서버데이터(JSON) ➡︎ 분석(Parse) ➡︎ 변환 (우리가 쓰려는 Struct/Class)
 ---
 */
// 서버에서 주는 데이터 ===========================================================
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
// 위에 구조체들은 맘대로 변경할 수 없음 서버에서 주는 형태이기 때문에 Int형으로 만들고 가공한다던지 불가


// 내가 만들고 싶은 데이터 (우리가 쓰려는 Struct / Class) =======================
struct Movie {
    static var movieId: Int = 0   // 아이디가 하나씩 부여되도록 만듦
    let movieName: String
    let rank: Int
    let openDate: String
    let todayAudience: Int      //원래 데이터에서 숫자형으로만 변경한 형태임 알아보기 쉽게 변수 이름 바꿔주고
    let totalAudience: Int
    
    init(movieNm: String, rank: String, openDate: String, audiCnt: String, accAudi: String) {
        self.movieName = movieNm
        self.rank = Int(rank)!
        self.openDate = openDate
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(accAudi)!
        Movie.movieId += 1                  // 객체 하나 찍어내면 증가
    }
    
}



// 서버와 통신 ===========================================================

// 서버 통신 코드를 구조체 안에 담았음 일반적으로 앱을 만들고 그안에서 통신할때 이렇게 감쌓음 그리고 Manager 라는 이름을 부여함
struct MovieDataManager {
    
    let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    
    let myKey = "7a526456eb8e084eb294715e006df16f"
        
    //                                                  [Movie]? 서버 통신하다 데이터 없으면 nil일 될 수 있어서
    // 그리고 이렇게 비동기적으로 동작하는 함수는 리턴값 fetchMovie(date: String) -> [Movie]? 이런식으로 사용안함
    func fetchMovie(date: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(movieURL)&key=\(myKey)&targetDt=\(date)"
        performRequest(with: urlString) { movies in // 아래에서 받은 클로저를 또 다음 클로저로 넘김
            completion(movies)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([Movie]?) -> Void) {
        print(#function)
        
        // 1. URL 구조체 만들기
        guard let url = URL(string: urlString) else { return }
        
        // 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할)
        let session = URLSession(configuration: .default)
        
        // 3. 세션에 작업 부여
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            
            // 데이터 분석하기
            if let movies = self.parseJSON(safeData) { // 함수실행하고 나온걸 바로 옵셔널 바인딩 하는 코드
            //self 붙은이유 클로저에서 객체의 속성이나 메서드 접근시 붙여줘야한다고 했었음
                //print("parse")
                completion(movies)      // 현재 결과물이 nil 아니면 영화 배열이 나오는 데 그걸 다음 클로저로 전달함
            } else {
                completion(nil)
            }
        }
        
        // 4.Start the task
        task.resume()   // 일시정지된 상태로 작업이 시작하기 때문
    }
    
    // 데이터 분석함수
    func parseJSON(_ movieData: Data) -> [Movie]? {
        // 함수실행 확인 코드
        print(#function)// 함수의 이름을 출력해줌 지금 어떤 함수가 실행 되고 있는지를 알 수 있음
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            
            let dailyLists = decodedData.boxOfficeResult.dailyBoxOfficeList
            
            // 반복문으로 movie배열 생성 ⭐️
//            var myMovielists = [Movie]()  //내가 만들고 싶은 타입의 배열로 만들기 위해
//
//            for movie in dailyLists { // 서버에서 온 배열을 하나하나 꺼내서 담는 것임
//
//                let name = movie.movieNm
//                let rank = movie.rank
//                let openDate = movie.openDt
//                let todayAudi = movie.audiCnt
//                let accAudi = movie.audiAcc
//
//                let myMovie = Movie(movieNm: name, rank: rank, openDate: openDate, audiCnt: todayAudi, accAudi: accAudi) // 붕어빵을 하나하나 찍고 내가 만들고 싶은 타입의 배열에 추가
//
//                myMovielists.append(myMovie)
//            }
            
            // 고차함수를 이용해 movie배열 생성하는 경우 ⭐️
            let myMovielists = dailyLists.map {
                Movie(movieNm: $0.movieNm, rank: $0.rank, openDate: $0.openDt, audiCnt: $0.audiCnt, accAudi: $0.audiAcc)
            }// 하나하나 Movie 인스턴스로 찍고 담고 있는 것임
            
            return myMovielists
            
        } catch {
            //print(error.localizedDescription)
            
            // (파싱 실패 에러)
            print("파싱 실패")
            
            return nil
        }
        
    }
    
}


// 뷰컨트롤러에서 일어나는 일 ===========================================================
// 빈배열
var downloadedMovies = [Movie]()

// 데이터를 다운로드 및 분석/변환하는 구조체
let movieManager = MovieDataManager()


// 실제 다운로드 코드
movieManager.fetchMovie(date: "20210201") { (movies) in
    
    if let movies = movies {
        
        // 배열 받아서 빈배열에 넣기
        downloadedMovies = movies
        dump(downloadedMovies)
        
        print("전체 영화 갯수 확인: \(Movie.movieId)")
    } else {
        print("영화데이터가 없습니다. 또는 다운로드에 실패했습니다.")
    }
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
