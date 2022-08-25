/* 
기본 데이터 타입은 아니지만 데이터 타입에 위치해서 표현하는 역할을 수행하는 
Any, AnyObject, nil 을 알아볼거임

Any - Swift의 모든 타입을 지칭하는 키워드
AnyObject - 모든 클래스 타입을 지칭하는 프로토콜 (프로토콜 나중에 학습 할거임)
nil - 없음을 의미하는 키워드
다른 언어의 NULL, Null, null 등과 유사한 표현입니다.

*/

// MARK: - Any 
var someAny: Any = 100  // 데이터 타입에 위치에 들어올수 있음 
someAny = "어떤 타입도 수용 가능합니다"
someAny = 123.12

// let someDouble: Double = someAny  // 컴파일 오류발생
// Any 타입에 Double 자료를 넣어두었더라도 Any는 Double 타입이 아니기 때문에 할당할 수 없습니다. 
// 명시적으로 타입을 변환해 주어야 합니다. 타입 변환은 차후에 다룹니다


// MARK: - AnyObject
class SomeClass {}

// 현제 SomeClass() 의 인스턴스를 someAnyObject에 넣어둠 
var someAnyObject: AnyObject = SomeClass()
// AnyObject는 클래스의 인스턴스만 수용 가능하기 때문에 클래스의 인스턴스가 아니면 할당할 수 없습니다.

//someAnyObject = 123.12    // 컴파일 오류발생
// 사실 이전시간에 배웠던 swift의 기본 데이터 타입들은 구조체로 되어 있음 


// MARK : - nil 
//아래 코드에서 someAny는 Any 타입이고, someAnyObject는 AnyObject 타입이기 때문에 nil을 할당할 수 없습니다.
// nil을 다루는 방법은 옵셔널 파트에서 다룹니다.

someAny = nil         // 컴파일 오류발생
// 어떤 타입이던 가질수 있는 Any 타입이라도 빈 값을 가질수는 없음 

someAnyObject = nil   // 컴파일 오류발생