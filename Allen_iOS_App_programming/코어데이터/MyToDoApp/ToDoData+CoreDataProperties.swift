//
//  ToDoData+CoreDataProperties.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//
//

import Foundation
import CoreData


/*
 확장에서는 저장 속성을 만들 수 가 없음 문법적으로 이건 계산 속성이라고 생각해야함 하나하나 파일이랑 연결 되서
 
 
 어쨋든 ToDoData 라는 모델은 만든 것임 
 */

extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64

    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}

extension ToDoData : Identifiable {

}
