/*
정의 문법
스위프트의 열거형은 다른 언어의 열거형과는 많이 다릅니다. 잘 살펴보아야 할 스위프트의 기능 중 하나입니다.

다른 언어 열거형과 다르게 굉장히 강력한 기능을 가짐 

enum은 타입이므로 대문자 카멜케이스를 사용하여 이름을 정의합니다
각 case는 소문자 카멜케이스로 정의합니다
각 case는 그 자체가 고유의 값입니다
각 케이스는 한 줄에 개별로도, 한 줄에 여러개도 정의할 수 있습니다
enum 이름 {
	case 이름1
	case 이름2
	case 이름3, 이름4, 이름5
	// ...
}
*/


//열거형 사용
enum Weekday {
    case mon
    case tue
    case wed
    case thu, fri, sat, sun
}

// 열거형 타입과 케이스를 모두 사용하여도 됩니다
var day: Weekday = Weekday.mon

// 타입이 명확하다면 .케이스 처럼 표현해도 무방합니다
day = .tue  // 현제 타입이 day: Weekday 명시되어 있어서 가능
// 만약 var day = .mon 어떤 힌트도 없이 이렇게 쓰면 
// 컴파일러는 어떤 열거형의 어떤 케이스 인지 알수가 없음 
// 그래서 최소한 처음 선언할때는 var day: Weekday = Weekday.mon
// 이렇게 타입 명시 해주는게 중요함 

print(day) // tue



// switch의 비교값에 열거형 타입이 위치할 때
// 이 케이스는 한정 되어 있다고 컴파일러는 알수 있음
// 월, 화, 수, 목, 금,  토, 일 중 하나는 걸리겠지라고 생각하는 것임

// 모든 열거형 케이스를 포함한다면 ex 월, 화, 수, 목, 금, 토, 일 
// default를 작성할 필요가 없습니다
// 하지만 하나라도 빠진다면 default 작성해야함 
switch day {
case .mon, .tue, .wed, .thu:
    print("평일입니다")
case Weekday.fri:
    print("불금 파티!!")
case .sat, .sun:
    print("신나는 주말!!")
}
// 평일입니다



//원시값
// C 언어의 enum처럼 정수값을 가질 수도 있습니다. 
// rawValue를 사용하면 됩니다. case별로 각각 다른 값을 가져야합니다
// 열거형 이름에다 : 찍고 원시값 가질 타입을 입력하면 됨 
// 자동으로 1식 증가함 peach 는 2

enum Fruit: Int {
    case apple = 0
    case grape = 1
    case peach
    
    // mango와 apple의 원시값이 같으므로 
    // mango 케이스의 원시값을 0으로 정의할 수 없습니다
//    case mango = 0
}

print("Fruit.peach.rawValue == \(Fruit.peach.rawValue)")
// Fruit.peach.rawValue == 2
// 값을 꺼내올때 이렇게 씀 


//정수 타입 뿐만 아니라 Hashable 프로토콜을 따르는 모든 타입이 원시값의 타입으로 지정될 수 있습니다.

enum School: String {
    case elementary = "초등"
    case middle = "중등"
    case high = "고등"
    case university
}

print("School.middle.rawValue == \(School.middle.rawValue)")
// School.middle.rawValue == 중등

// 열거형의 원시값 타입이 String일 때, 원시값이 지정되지 않았다면
// case의 이름을 원시값으로 사용합니다
print("School.university.rawValue == \(School.university.rawValue)")
// School.middle.rawValue == university





//원시값을 통한 초기화
//rawValue를 통해 초기화 할 수 있습니다. 
//rawValue가 case에 해당하지 않을 수 있으므로
//rawValue를 통해 초기화 한 인스턴스는 옵셔널 타입입니다.

// rawValue를 통해 초기화 한 열거형 값은 옵셔널 타입이므로 Fruit 타입이 아닙니다

//let apple: Fruit = Fruit(rawValue: 0)  3이상이 없기에 넣으면 오류 날수 있어서
let apple: Fruit? = Fruit(rawValue: 0) // ? 키워드 필요 옵셔널 타입으로 선언해야함 nil이 나올수 있어서



// if let 구문을 사용하면 rawValue에 해당하는 케이스를 곧바로 사용할 수 있습니다
if let orange: Fruit = Fruit(rawValue: 5) {
    print("rawValue 5에 해당하는 케이스는 \(orange)입니다")
} else {
    print("rawValue 5에 해당하는 케이스가 없습니다")
} // rawValue 5에 해당하는 케이스가 없습니다



//메서드
//스위프트의 열거형에는 메서드도 추가할 수 있습니다.

enum Month {  // 12 월 까지 만들어 줬고 
    case dec, jan, feb
    case mar, apr, may
    case jun, jul, aug
    case sep, oct, nov
    
    func printMessage() {  // 케이스에 해당하는 값에 따라 동작
        switch self {
        case .mar, .apr, .may:
            print("따스한 봄~")  
        case .jun, .jul, .aug:
            print("여름 더워요~")
        case .sep, .oct, .nov:
            print("가을은 독서의 계절!")
        case .dec, .jan, .feb:
            print("추운 겨울입니다")
        }
    }
}

Month.mar.printMessage()
// 따스한 봄~

