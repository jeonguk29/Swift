//
//  CoreDataManager.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)
// - 코어데이터 통신 모델 일반적으로 싱글 톤으로 구현
final class CoreDataManager {
    
    // 싱글톤으로 만들기
    // - 로컬 저장소랑 데이터를 주고 받을 수 있는 싱글톤 메니져를 만듬
    // - 컨트롤러가 이 싱글톤 객체(메니져)를 통해 언제든지 데이터를 물어보고 받을 수 있는 구조임
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    // 앱이 실행 될때 하나의 앱을 관리 하는 객체 
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    // -컨테이너에 접근해서 임시저장소를 담아 놓음
    // -코어데이터에서 가장 중요한 부분은 어떻게 보면 임시저장소임 언제든지 임시저장소에 접근해서 일들을 하기 때문에 이 변수를 만들어 놓을 필요가 있음
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "ToDoData"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    // - 데이터 달라고 하면 실제 하드에 저장된 ToDoData 타입의 데이터 주면 될 것임
    func getToDoListFromCoreData() -> [ToDoData] {
        var toDoList: [ToDoData] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // entityName은 우리가 데이터를 하드에 저장하는 실체를 말함 == ToDoData
            
            // 정렬순서를 정해서 요청서에 넘겨주기
            // - 데이터를 가져올때 어떠한 기준으로 데이터 가져올지 기준이 필요함
            // - 현제 우리가 정의한 모델의 date 날짜 기준으로 내림차순 해서 가져다 달라고 정함 + ascending: true 는 오름 차순
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                // - fetch 메서드는 요청서가 필요
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    toDoList = fetchedToDoList
                    //NSManagedObject 반환 되기 때문에 ToDoData 로 타입 캐스팅 해서 사용
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        return toDoList
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    // - 우리가 만들려는 toDoText 즉 글 내용과, 백그라운드 색상을 정해서 데이터생성후 임시 저장소에 저장해두고 영구 저장소까지 저장 하는 코드임
    func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            // - 문자열과 임시 저장소를 가지고 실제적으로 생성하고 싶은 데이터의 형태를 그려주는 타입임
            // 그러면 entity 에는 실체가 들어 있고
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                // - 실체와 임시저장소 두개 가지고 관리 객체를 생성 할 수 있음 (타입 케스팅으로 구체적 형으로 만든 후)
               
                /* toDoData = ToDoData(context:context)
                
                 이렇게도 아래 코드와 동일하게 관리 객체를 만들 수 있는데 임시 저장소가 정말 중요한 역할을 하는 것임
                 */
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                    
                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
                    toDoData.memoText = toDoText
                    toDoData.date = Date()   // 날짜는 저장하는 순간의 날짜로 생성
                    toDoData.color = colorInt
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                    
                    // 임시저장소에 접근해서 변경된 데이터 있는지 확인하고 변경된 데이터 있다면 영구저장소에 저장
                    if context.hasChanges {
                        do {
                            try context.save()
                            // context임시 저장소에 save() 메서드가 의미하는게 영구 저장소에 저장하겠다는 것임
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
  
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    // - 지우고 싶은 데이터 전달해주면 날짜를 확인 (하드에 이 데이터가 있는지 먼저 확인하고 지우기 위함)
    func deleteToDo(data: ToDoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = data.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            // - 여기도 요청서가 필요함 데이터를 일단 가져온 후 삭제해야해서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            // predicate 는 단서라는 뜻 NSPredicate 타입이 있는데 단서 문자열과 실제 date 타입 전달 해줘야함
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                // - 임시 저장소에서 일단 데이터를 가져옴
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    // - 첫번째 요소를 가져옴 동일한 시간으로 저장된 놈은 하나 밖에 없을 것이라
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        // 임시저장소에서 지우고
                        
                        // 임시 저장소 내용 바뀌면 영구저장소에 저장(지운것을 버리고)
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    // - 삭제에서 한것과 매우 유사함
    func updateToDo(newToDoData: ToDoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newToDoData.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetToDo = newToDoData
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
}
