//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import Foundation

//MARK: - 네트워크에서 발생할 수 있는 에러 정의

// Result 타입 사용하기 때문에 실패케이스일때 NetworkError 에러를 던지기 때문에 사전에 에러 타입 정의를 해줘야함
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking (서버와 통신하는) 클래스 모델


// fetchMusic만 외부에서 실행 가능하게 private 키워드를 붙이지 않음 

final class NetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    //let musicURL = "https://itunes.apple.com/search?media=music"
    
    // 별명 만들기 오른쪽 타입을 해당이름으로 사용하게 만듯 것
    // 현재 만든게 비동기 처리함수의 결과를 받기위해 콜백함수 형태를 잡아준것임
    // 애플이 만든 Result 타입은 성공 case, 실패 case를 담을 수 있음
    // [Music]? 이렇게 해도 되지만 좀더 정확한 오류를 검출 하기 위해 사용
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    // 해당 타입으로 뷰컨트롤러에 반환 할 것임 

    // 네트워킹 요청하는 함수 (음악데이터 가져오기)
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        print(urlString)
        // name Space 만들어 URL을 만듬
        
        
        // 기존과 다르게 Request하는 함수를 분리 시켰음 만든 URL 넘겨주고
        performRequest(with: urlString) { result in
            completion(result) // 전달 받은 result 타입을 콜백으로 다시 넘겨줌
        }
        
    }
    
    // 실제 Request하는 함수 (비동기적 실행 ===> 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        //print(#function)
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let musics = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(musics))
                //⭐️ 안전한 데이터로 파싱 parseJSON 메서드 사용
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ musicData: Data) -> [Music]? {
        //print(#function)
    
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results // [Music]를 리턴함
        // 실패
        } catch {
            print(error.localizedDescription) // 에러를 좀더 자세하게 출력
            return nil
        }
    }
}
