//
//  Constants.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import UIKit

//MARK: - Name Space 만들기

// 데이터 영역에 저장 (열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)
// 사용하게될 API 문자열 묶음
public enum MusicApi {
    //case mon
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music" // 음악이 아니면 media=movie    이렇게만 해주면 됨
    //var name = "안녕"
}
// ⭐️ 이렇게 열거형으로도 만들수 있음 구조체를 사용할때는 다른 곳에서 인스턴스를 만들지 못하게 만들어 주면 되고
// MusicApi.mon 열거형은 이런식으로 만드는게 생성자인데 이런 케이스를 만들지 않고 타입 저장 속성으로 만들면
// MusicApi.requestUrl 이런 식으로 접근 가능함 열거형 혹은 구조체를 많이 사용함 (단 둘다 생성자를 사용하지 못하게 열거형은 case가 없으면 됨)
/*
 열거형 같은 경우는 저장속성을 가질수가 없음 타입 저장속성이라 만들수가 있는 것임 데이터 영역에 만드는 것이라
 */

// 사용하게될 Cell 문자열 묶음
// ⭐️이렇게 타입 저장 속성으로 만들면 메모리 구조상 데이터 영역에 생기는 것임
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {}
    // Cell() 이런식으로 사용할 수 없게 생성자를 맊음 구조체 인스터스를 만들수 없게 만든 것임
    // 언제든지 타입 저장속성에만 접근을 해서 사용하기 위해 막은것임 
}




// 컬렉션뷰 구성을 위한 설정
public struct CVCell {
    static let spacingWitdh: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}


//let REQUEST_URL = "https://itunes.apple.com/search?"
