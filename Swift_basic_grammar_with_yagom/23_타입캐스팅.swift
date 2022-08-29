// 스위프트의 타입캐스팅은 인스턴스의 타입을 확인 하는 용도
// 또는 클래스의 인스턴스를 부모 혹은 자식 클래스의 타입으로 
// 사용할 수 있는지 확인 하는 용도로 사용합니다. is, as를 사용합니다.

/*
let someInt: Int = 100
let someDouble: Double = Double(someInt)

기존 다른 언어에서 타입 케이팅을 이런식으로 했었음 
이건 실질적으로 스위프트에서 타입 케스팅이 아님 
이건 더블타입에 인스턴스를 하나더 생성 해주는 것임 

주로 스위프트에서 타입 케스팅은 클레스 인스턴스에서 사용 많이함 

*/


//타입 캐스팅 예제를 위한 클래스 정의
class Person {
    var name: String = ""
    func breath() {
        print("숨을 쉽니다")
    }
}

class Student: Person { // 사람 상속 받은 학생 클레스
    var school: String = ""
    func goToSchool() {
        print("등교를 합니다")
    }
}

class UniversityStudent: Student { // 사람 상속 받은 학생 클레스를 상속받은 대학생 클레스 
    var major: String = ""
    func goToMT() {
        print("멤버쉽 트레이닝을 갑니다 신남!")
    }
}
// 인스턴스 생성
var woogie: Person = Person()
var hana: Student = Student()
var jason: UniversityStudent = UniversityStudent()


//타입 확인
//is를 사용하여 타입을 확인합니다.  (결과는 true, false 값으로 나옴)

var result: Bool

result = woogie is Person // true
result = woogie is Student // false
result = woogie is UniversityStudent // false

result = hana is Person // true
result = hana is Student // true
result = hana is UniversityStudent // false

result = jason is Person // true
result = jason is Student // true
result = jason is UniversityStudent // true


// 조건문에서 사용 
if woogie is UniversityStudent {
    print("woogie은 대학생입니다")
} else if woogie is Student {
    print("woogie은 학생입니다")
} else if woogie is Person {
    print("woogie은 사람입니다")
} // woogie은 사람입니다

switch jason {
case is Person:
    print("jason은 사람입니다")
case is Student:
    print("jason은 학생입니다")
case is UniversityStudent:
    print("jason은 대학생입니다")
default:
    print("jason은 사람도, 학생도, 대학생도 아닙니다")
} // jason은 사람입니다

switch jason {
case is UniversityStudent:
    print("jason은 대학생입니다")
case is Student:
    print("jason은 학생입니다")
case is Person:
    print("jason은 사람입니다")
default:
    print("jason은 사람도, 학생도, 대학생도 아닙니다")
} // jason은 대학생입니다


//업 캐스팅
//as를 사용하여 부모클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 타입정보를 전환해줍니다. 
//Any 혹은 AnyObject로도 타입정보를 변환할 수 있습니다. 
// 암시적으로 처리되므로 꼭 필요한 경우가 아니라면 생략해도 무방합니다.
// 많이 사용 안함 

// UniversityStudent 인스턴스를 생성하여 Person 행세를 할 수 있도록 업 캐스팅
var mike: Person = UniversityStudent() as Person
// 대학생은 사람 이라 이렇게 바꾸는게 가능함 

var jenny: Student = Student()
//var jina: UniversityStudent = Person() as UniversityStudent // 컴파일 오류

// UniversityStudent 인스턴스를 생성하여 Any 행세를 할 수 있도록 업 캐스팅
var jina: Any = Person() // as Any 생략가능
// Any는 어떤 타입이던 다 가능하니까 가능함 

/*
다운 캐스팅
as? 또는 as!를 사용하여 자식 클래스의 인스턴스로 사용할 수 있도록
컴파일러에게 인스턴스의 타입정보를 전환해줍니다.

조건부 다운 캐스팅
as?를 사용합니다. 캐스팅에 실패하면, 
//즉 캐스팅하려는 타입에 부합하지 않는 인스턴스라면 nil을 반환하기 때문에 결과의 타입은 옵셔널 타입입니다.
*/
var optionalCasted: Student?

optionalCasted = mike as? UniversityStudent  // 대학생 타입으로 사용 가능해?

// 사람이나 일반 학생 타입인 애들은 nil 옵셔널 값 들어감 
optionalCasted = jenny as? UniversityStudent // nil
optionalCasted = jina as? UniversityStudent // nil
optionalCasted = jina as? Student // nil

//강제 다운 캐스팅
//as!를 사용합니다. 캐스팅에 실패하면, 
//즉 캐스팅하려는 타입에 부합하지 않는 인스턴스라면 런타임 오류가 발생합니다. 
//캐스팅에 성공하면 옵셔널이 아닌 일반 타입을 반환합니다.

var forcedCasted: Student

optionalCasted = mike as! UniversityStudent  // 너 대학생 해!!!! (가능 오류 없음)

// 아니면 오류가 남 옵셔널 반환이 아니고
//optionalCasted = jenny as! UniversityStudent // 런타임 오류
//optionalCasted = jina as! UniversityStudent // 런타임 오류
//optionalCasted = jina as! Student // 런타임 오류



//활용
func doSomethingWithSwitch(someone: Person) {
    switch someone {
    case is UniversityStudent:
        (someone as! UniversityStudent).goToMT()
    case is Student:
        (someone as! Student).goToSchool()
    case is Person:
        (someone as! Person).breath()
    }
}

doSomethingWithSwitch(someone: mike as Person) // 멤버쉽 트레이닝을 갑니다 신남!
doSomethingWithSwitch(someone: mike) // 멤버쉽 트레이닝을 갑니다 신남!
doSomethingWithSwitch(someone: jenny) // 등교를 합니다
doSomethingWithSwitch(someone: woogie) // 숨을 쉽니다


func doSomething(someone: Person) {
    if let universityStudent = someone as? UniversityStudent {
        universityStudent.goToMT()
    } else if let student = someone as? Student {
        student.goToSchool()
    } else if let person = someone as? Person {
        person.breath()
    }
}

doSomething(someone: mike as Person) // 멤버쉽 트레이닝을 갑니다 신남!
doSomething(someone: mike) // 멤버쉽 트레이닝을 갑니다 신남!
doSomething(someone: jenny) // 등교를 합니다
doSomething(someone: woogie) // 숨을 쉽니다

/*
타입 케스팅 스위프트에서 굉장히 중요함 그리고 딕셔너리 사용할때도 많이 사용함 

*/