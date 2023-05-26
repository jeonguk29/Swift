//
//  Memo.swift
//  ToDoApp
//
//  Created by 정정욱 on 2023/05/12.
//

import Foundation

// 이러한 모델을 코어 데이터를 사용할때는
// xcdataamodeld 파일에 만들어야함
struct Memo {
    var memoText: String?
    var data: Data?
    var color: Int
}
