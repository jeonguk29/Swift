/*
상속
스위프트의 상속은 클래스, 프로토콜 등에서 가능합니다. 
열거형, 구조체는 상속이 불가능합니다. 
스위프트는 다중상속을 지원하지 않습니다. (스위프트는 단일 상속임)
이번 파트에서는 클래스의 상속에 대해서 알아봅니다\

*/
/*
클래스의 상속과 재정의
상속 문법
class 이름: 상속받을 클래스 이름 {
    /* 구현부 */
}

*/
// 기반 클래스 Person
class Person {
    var name: String = ""
    
    func selfIntroduce() {
        print("저는 \(name)입니다")
    }
    
    // final 키워드를 사용하여 재정의(오버라이드)를 방지할 수 있습니다
    final func sayHello() {
        print("hello")
    }
    
    // 타입 메서드
    // 재정의 불가 타입 메서드 - static  (자식 클레스 재정의 불가능)
    static func typeMethod() {
        print("type method - static")
    }
    
    // 재정의 가능 타입 메서드 - class (자식 클레스 재정의 가능)
    class func classMethod() {
        print("type method - class")
    }
    
    // 재정의 가능한 class 메서드라도 
    // final 키워드를 사용하면 재정의 할 수 없습니다
    // 메서드 앞의 `static`과 `final class`는 똑같은 역할을 합니다
    final class func finalCalssMethod() {
        print("type method - final class")
    }


    /*
    class 수식이 붙은 타입메서드는 인스턴스에서 사용할 수 없으며, 
    인스턴스 메서드는 타입 그 자체에서 사용할 수 없죠. 
    타입 그 자체가 사용할 수 있는 메서드라고 생각하면 됩니다.
    */
}

// Person을 상속받는 Student
class Student: Person {
    // var name: String = ""  오류남 상속 받았기 때문에 사용할수 있는데 또 선언하려고 하면 오류나는것임 
    var major: String = ""
    

    // override  키워드로 부모 메서드 재정의 가능 
    override func selfIntroduce() {
        print("저는 \(name)이고, 전공은 \(major)입니다")
        // super.selfIntroduce() 이렇게 쓰면 부모 함수 사용 가능 
    }
    
    override class func classMethod() {
        print("overriden type method - class")
    }
    
    // static을 사용한 타입 메서드는 재정의 할 수 없습니다
//    override static func typeMethod() {    }
    
    // final 키워드를 사용한 메서드, 프로퍼티는 재정의 할 수 없습니다
//    override func sayHello() {    }
//    override class func finalClassMethod() {    }

}

// 동작 확인
let woogie: Person = Person()
let hana: Student = Student()

woogie.name = "woogie"
hana.name = "hana"  // 상속 받은거라 name 사용 가능
hana.major = "Swift"
// woogie.major 는 사용 안됨 


// 둘다 selfIntroduce() 동작 이 다름 자식에서 재정의 한 결과로 나오기 때문
woogie.selfIntroduce()
// 저는 woogie입니다

hana.selfIntroduce()
// 저는 hana이고, 전공은 Swift입니다

Person.classMethod()
// type method - class

Person.typeMethod()
// type method - static

Person.finalCalssMethod()
// type method - final class


Student.classMethod()
// overriden type method - class  : 재정의 해준놈 으로 나오고


// 아래는 재정의 못하기에 그대로 출력나옴 
Student.typeMethod()  
// type method - static

Student.finalCalssMethod()
// type method - final class