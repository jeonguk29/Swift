/*
프로퍼티
프로퍼티는 클래스, 구조체, 열거형과 연관된 값입니다. 
타입과 관련된 값을 저장할 수도, 연산할 수도 있습니다.


프로퍼티의 종류
인스턴스 저장 프로퍼티
타입 저장 프로퍼티
인스턴스 연산 프로퍼티
타입 연산 프로퍼티
지연 저장 프로퍼티

이번 파트에서는 지연 저장 프로퍼티를 제외한 저장 프로퍼티와 연산 프로퍼티에 대해 알아봅니다.

정의와 사용
프로퍼티는 구조체, 클래스, 열거형 내부에 구현할 수 있습니다. 다만 열거형 내부에는 연산 프로퍼티만 구현할 수 있습니다. 연산 프로퍼티는 var로만 선언할 수 있습니다. 연산프로퍼티를 읽기전용으로는 구현할 수 있지만, 쓰기 전용으로는 구현할 수 없습니다. 읽기전용으로 구현하려면 get 블럭만 작성해주면 됩니다. 읽기전용은 get블럭을 생략할 수 있습니다. 읽기, 쓰기 모두 가능하게 하려면 get 블럭과 set블럭을 모두 구현해주면 됩니다.
set 블럭에서 암시적 매개변수 newValue를 사용할 수 있습니다.

*/


// 프로퍼티는 클래스, 구조체, 열거형 안쪽에 구현 해줄수 있음

struct Student {
    
    // 인스턴스 저장 프로퍼티
    var name: String = ""
    var `class`: String = "Swift"
    var koreanAge: Int = 0
    
    // 인스턴스 연산 프로퍼티 : 특정 연산을 수행해주는 프로퍼티임
    // 기존 프로퍼티는 어떤 값을 저장을 하기 위한 프로퍼티였음
    // 연산 프로퍼티는 값들을 연산 해주기 위한 프로퍼티임

    var westernAge: Int {  //westernAge 는 값저장이 아니라
        get {
            return koreanAge - 1  // 값을 불러올땐 여기가 실행 
        }
        
        set(inputValue) { // 여기에 값을 셋팅해주면 
            koreanAge = inputValue + 1 // koreanAge 프로퍼티에 값을 연산을 해서 할당해주는 거임
        }
    }

    // 즉 값 대입 하면 set부분 정의한데로, 값 뽑을때는 get 정의한데로 
    

    // 타입 저장 프로퍼티   (static  요런거 붙는걸 말함)
    static var typeDescription: String = "학생"
    
    /*
    // 인스턴스 메서드
    func selfIntroduce() {
        print("저는 \(self.class)반 \(name)입니다")
    }
     */
    
    // 읽기전용 인스턴스 연산 프로퍼티
    // 간단히 위의 selfIntroduce() 메서드(메개변수, 반환값 없는)를 대체할 수 있습니다
    var selfIntroduction: String {
        get {
            return "저는 \(self.class)반 \(name)입니다"
        }  // get만 구현 되어 있으면 읽기전용임 + set만으로(쓰기전용)으로만 사용 못함
    }
        
    /*
     // 타입 메서드
     static func selfIntroduce() {
     print("학생타입입니다")
     }
     */
    
    // 읽기전용 타입 연산 프로퍼티
    // 읽기전용에서는 get을 생략할 수 있습니다
    static var selfIntroduction: String {
        return "학생타입입니다"
    }
}

// 타입 연산 프로퍼티 사용
print(Student.selfIntroduction)
// 학생타입입니다

// 인스턴스 생성
var woogie: Student = Student()
woogie.koreanAge = 10  // 값 10으로 셋팅

// 인스턴스 저장 프로퍼티 사용
woogie.name = "woogie"
print(woogie.name)
// woogie

// 인스턴스 연산 프로퍼티 사용
print(woogie.selfIntroduction)
// 저는 Swift반 woogie입니다

print("제 한국나이는 \(woogie.koreanAge)살이고, 미쿡나이는 \(woogie.westernAge)살입니다.")
// 제 한국나이는 10살이고, 미쿡나이는 9살입니다. = 미국나이에 get부분에서 한살빼서 가져옴


//응용 환율 돈 계산 

struct Money {
    var currencyRate: Double = 1100
    var dollar: Double = 0
    var won: Double {
        get {
            return dollar * currencyRate // 값 가져올때는 달러에 원 곱한걸로 가져옴
        }
        set {
            dollar = newValue / currencyRate
        } // 원에 값 셋팅시는 달러에 수식정용한거로 넣고 1,2,3, 달러 되게
        // 위에서는(inputValue) 이런식으로 새로 전달될 값을 명시해줬는데
        // newValue  라고 써줌 특별히 매개변수 정해주지 않으면 자동으로 newValue가 암시적으로 들어옴 
    }
}

var moneyInMyPocket = Money()

moneyInMyPocket.won = 11000 // set부분 실행 

print(moneyInMyPocket.won)
// 11000.0

moneyInMyPocket.dollar = 10 

print(moneyInMyPocket.won)
// 11000.0

/*
지역변수 및 전역변수
저장 프로퍼티와 연산 프로퍼티의 기능은 함수, 메서드, 클로저, 타입 등의 외부에 위치한 지역/전역 변수에도 모두 사용 가능합니다.
*/

var a: Int = 100
var b: Int = 200
var sum: Int {
    return a + b
}

print(sum) // 300