import UIKit


// 실제 API에서 받게 되는 정보

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music] // 배열이 오는 것임 (아래 음악 구조체로 음악 값들이)
}

// 실제 우리가 사용하게될 음악(Music) 모델 구조체
// (서버에서 가져온 데이터만 표시해주면 되기 때문에 일반적으로 구조체로 만듦)


// + ⭐️ 서버에서 주는 데이터가 없을 수도 있기 때문에 오류 없이 처리하려면 옵셔널로 바꿔주는게 좋음
// 일반적으로 서버 쪽에서 날라오는 데이터는 옵셔널로 처리를함
struct Music: Codable {
    let songName: String?
    let artistName: String?
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    private let releaseDate: String?
    
    // 네트워크에서 주는 이름을 변환하는 방법 (원시값)
    // (서버: trackName ===> songName)
    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
    
}

/*
콜백함수를 사용하여 설계를 해야함
즉  musicArray = MusicData.results 배열이 생기는 이 시점에 다른 함수를 호출하여 결과 값을 리턴 해야함
 getMethod를 실행시킬때 함수를 파라미터로 받음 이 파라미터가 나중에 콜백 함수로 쓰일 것임
 일반적으로 이 콜백함수는 우리가 전달하고 싶은 데이터 형태를 넣고 반환 타입은 거의 무조건 Void임
*/
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
getMethod { musicArray in
    guard let array = musicArray else {return} // 여기 리턴은 현제 이 클로저를 벗어나겠다는 뜻
    dump(array)
}

// 즉 비동기 처리일때 콜백함수를 통해서 데이터를 전달 받아야지만 실제로 이 비동기 처리가 끝난 시점에 데이터를 받을 수가 있는 것임




//struct MusicData: Codable {
//    let numberOfResults: Int // 50개의 결과의 개수
//    let results: [Music] // results 라는 딕셔너리 속성의 값이 Music 배열 타입
//
//    // ⭐️이름을 바꾸고 싶을때 아래에서 설명한 것처럼 이렇게 바꾸면 되고 규칙은 바꾸려고 하지 않는 이름들도 일단 기입을 해줘야함
//    enum CodingKeys: String, CodingKey {
//        case numberOfResults = "resultCount"
//        case results
//    }
//}
//
//// MARK: - Result
//struct Music: Codable {
//    // 실제 서버에서 우리가 다룰 것만 두고 나머지는 다 지우면 됨
//    let artistName: String
//    let collectionName: String
//    let songName: String
//    let previewURL: String
//    let artworkUrl100: String
//    let releaseDate: Date
//
//
//    // 이 열거형이 의미하는 것은 실제로 서버에서 주는 이름을 정의 한 것이고 만약 파이썬 같은 곳에서
//    // 변수 명을 만들때 artist_name 이렇게 날라 올 수 도 있음 그러면 우리가 앱에서 정의할 이름으로 바꿔 주면 됨
//    // case artistName = "artist_name"
//    // 즉 서버에서 사용하는 이름이랑 우리 앱에서 사용할 이름을 정의하는 부분임
//    // ⭐️ 서버에서 오는 데이터를 우리가 쓰고 싶은 이름으로 바꾸려면 CodingKey라는 프로토콜을 열거형에서 채택후
//    // 문자열 원시 값을 사용하고 뒤 쪽에다가 = "previewUrl" 처럼 서버에서 주는 이름을 사용한다고 생각 하면 됨
//
//    enum CodingKeys: String, CodingKey {
//
//        case artistName
//        case collectionName
//        case songName = "trackName"
//        case previewURL = "previewUrl"
//        case artworkUrl100
//        case releaseDate
//    }
//}




