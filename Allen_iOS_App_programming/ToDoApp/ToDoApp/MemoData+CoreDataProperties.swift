//
//  MemoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 정정욱 on 2023/05/12.
//
//

import Foundation
import CoreData

/*
 확장에서는 저장 속성을 만들 수 가 없음 문법적으로 이건 계산 속성이라고 생각해야함 하나하나 파일이랑 연결 되서
 */
extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64

}

extension MemoData : Identifiable {

}
