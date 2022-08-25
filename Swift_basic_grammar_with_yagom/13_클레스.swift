/*
클레스는 구조체와 매우 유사함 구조체는 값 타입인 반면 클래스는 참조 타입임


정의 문법
클래스는 참조 타입입니다. 
타입이름은 대문자 카멜케이스를 사용하여 정의합니다.

swift의 클레스는 다중 상속이 되지 않는 다는 것이 특징임


class 이름 {
	/* 구현부 */
}

클레스도 구조체와 유사하게 프로퍼티와 메소드를 가질수 있음 

프로퍼티 및 메서드 구현
클래스의 타입 메서드는 두 종류가 있습니다. 
상속 후 재정의가 가능한 class 타입메서드, 상속 후 재정의가 불가능한 static 타입메서드가 있습니다. 자세한 내용은 상속 부분에서 다시 다룹니다.
*/

class Sample {
    // 가변 프로퍼티
    var mutableProperty: Int = 100 

    // 불변 프로퍼티
    let immutableProperty: Int = 100 
    
    // 타입 프로퍼티
    static var typeProperty: Int = 100 
    
    // 인스턴스 메서드
    func instanceMethod() {
        print("instance method")
    }
    
    // 타입 메서드
    // 재정의 불가 타입 메서드 - static
    static func typeMethod() {
        print("type method - static")
    }
    
    // 재정의 가능 타입 메서드 - class
    class func classMethod() {
        print("type method - class")
    }
    // 위 둘다 타입 메서드라고 부르는데요 앞에 어떤 키워드가 붙었냐에 따라
    // 타입메서드 성질이 달라짐 

}

/*
클래스 사용
구조체와 다르게 let과 var를 사용한 인스턴스 모두가 mutableProperty 를 변경 할수 있음

*/
// 인스턴스 생성 - 참조정보 수정 가능
var mutableReference: Sample = Sample()

mutableReference.mutableProperty = 200

// 불변 프로퍼티는 인스턴스 생성 후 수정할 수 없습니다
// 컴파일 오류 발생
//mutableReference.immutableProperty = 200


// 인스턴스 생성 - 참조정보 수정 불가
let immutableReference: Sample = Sample()

// 클래스의 인스턴스는 참조 타입이므로 let으로 선언되었더라도 인스턴스 프로퍼티의 값 변경이 가능합니다
immutableReference.mutableProperty = 200

// 다만 참조정보를 변경할 수는 없습니다
// 컴파일 오류 발생
//immutableReference = mutableReference

// 참조 타입이라도 불변 인스턴스는 
// 인스턴스 생성 후에 수정할 수 없습니다
// 컴파일 오류 발생
//immutableReference.immutableProperty = 200


// 타입 프로퍼티 및 메서드
Sample.typeProperty = 300
Sample.typeMethod() // type method

// 인스턴스에서는 타입 프로퍼티나 타입 메서드를
// 사용할 수 없습니다
// 컴파일 오류 발생
//mutableReference.typeProperty = 400
//mutableReference.typeMethod()

// 학생 클래스 만들어보기
class Student {
	// 가변 프로퍼티
    var name: String = "unknown"

    // 키워드도 `로 묶어주면 이름으로 사용할 수 있습니다
    var `class`: String = "Swift"
    
    // 타입 메서드
    class func selfIntroduce() {
        print("학생타입입니다")
    }
    
    // 인스턴스 메서드
    // self는 인스턴스 자신을 지칭하며, 몇몇 경우를 제외하고 사용은 선택사항입니다
    func selfIntroduce() {
        print("저는 \(self.class)반 \(name)입니다")
    }
}

// 타입 메서드 사용
Student.selfIntroduce() // 학생타입입니다

// 인스턴스 생성
var woogie: Student = Student()
woogie.name = "woogie"
woogie.class = "스위프트"
woogie.selfIntroduce()   // 저는 스위프트반 woogie입니다

// 인스턴스 생성
let jina: Student = Student()
jina.name = "jina"
jina.selfIntroduce() // 저는 Swift반 jina입니다
