/* 
옵셔널 
스위프트 핵심 개념중 하나  

값이 있을수도, 없을수도 있음

옵셔널이 아닌 상수에다가 nil 값 넣으려고 하면 오류남 
let someConstant: Int =  nil 오류남  

왜 옵셔널이 필요한가

nil의 가능성을 명시적으로 표현
• nil 가능성을 문서화 하지 않아도 코드만으로
충분히 표현가능

• 문서/주석 작성 시간을 절약䯽
• 전달받은 값이 옵셔널이 아니라면 nil체크를
하지 않더라도 안심하고 사용䯽

• 효율적인 코딩
• 예외 상황을 최소화하는 안전한 코딩

let optionalValue: Optional<Int> = nil    아래 처럼 줄여 사용 가능 
let optionalValue: Int? = nil


옵셔널 표현방법음 ?, ! 2가지가 있음

*/


//MARK:- 암시적 추출 옵셔널
// Implicitly Unwrapped Optional

var implicitlyUnwrappedOptionalValue: Int! = 100

switch implicitlyUnwrappedOptionalValue {
case .none:
    print("This Optional variable is nil")   // 값이 없으면 
case .some(let value):
    print("Value is \(value)")   // 값 이 있으면 
}

// 기존 변수처럼 사용 가능
implicitlyUnwrappedOptionalValue = implicitlyUnwrappedOptionalValue + 1

// nil 할당 가능
implicitlyUnwrappedOptionalValue = nil

// 잘못된 접근으로 인한 런타임 오류 발생
//implicitlyUnwrappedOptionalValue = implicitlyUnwrappedOptionalValue + 1   //  nil 에 1더할수 없음


//MARK:- 옵셔널(일반)
// Optional

var optionalValue: Int? = 100  //(인트값이 있을수도 없을수도 있다는 뜻)

switch optionalValue {
case .none:
    print("This Optional variable is nil")
case .some(let value):
    print("Value is \(value)")
}

// nil 할당 가능
optionalValue = nil

// 기존 변수처럼 사용불가 - 옵셔널과 일반 값은 다른 타입이므로 연산불가 
// 아에 다른 데이터 타입과 연산이 안됨 nil이 아니더라도 
//optionalValue = optionalValue + 1
