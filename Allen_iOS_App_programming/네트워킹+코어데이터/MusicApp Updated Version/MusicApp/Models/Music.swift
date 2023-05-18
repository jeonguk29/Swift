//
//  Music.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import UIKit

//MARK: - 데이터 모델

// 실제 API에서 받게 되는 정보

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// 실제 우리가 사용하게될 음악(Music) 모델 클래스
// (저장여부 등을 지속적으로 관리(속성 변경 여부)해줘야해서, 클래스로 만듦)
// - 우리가 실제 애플에서 날아오는 데이터는 Music으로 받아주고 코어데이터에 저장할때 추가적인 데이터 더해서 MusicSaved로 바꿔 저장해주는 것임
final class Music: Codable {
    let songName: String?
    let artistName: String?
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    private let releaseDate: String?
    var isSaved: Bool = false // 저장되었는지 여부 판단, 기본으로 생성될때 저장되지 않았다고 디폴트 설정해줌
    
    // 네트워크에서 주는 이름을 변환하는 방법
    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
    
    // (출시 정보에 대한 날짜를 잘 계산하기 위해서) 계산 속성으로
    // "2011-07-05T12:00:00Z" ===> "yyyy-MM-dd"
    var releaseDateString: String? {
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return ""
        }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
}
