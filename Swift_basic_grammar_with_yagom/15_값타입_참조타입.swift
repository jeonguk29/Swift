/*
class
전통적인 OOP관점에서의 클래스 와 크게 다른점 없음 
단일상속 : 이게 가능함 
(인스턴스/타입)메서드
(인스턴스/타입) 프로퍼티

참조타입
Apple 프레임워크의 대부분의 큰 뼈대는 모두 클래스로 구성 



Struct 
C 언어 등의 구조체보다 다양한 기능
상속 불가
(인스턴스/타입)메서드
(인스턴스/타입) 프로퍼티

값 타입
swift의 대부분의 큰 뼈대는 모두 구조체로 구성 
*/

열거형과 구조체는 값 타입이며, 클래스는 참조 타입이라는 것이 가장 큰 차이입니다. 또한, 클래스는 상속이 가능하지만 구조체와 열거형은 상속이 불가능합니다.

struct ValueType {
    var property = 1
}

class ReferenceType {
    var property = 1
}

// 첫 번째 구조체 인스턴스
let firstStructInstance = ValueType()
// 두 번째 구조체 인스턴스에 첫 번째 인스턴스 값 복사
var secondStructInstance = firstStructInstance
// 두 번째 구조체 인스턴스 프로퍼티 값 수정
secondStructInstance.property = 2

// 두 번째 구조체 인스턴스는 첫 번째 구조체를 똑같이 복사한 
// 별도의 인스턴스이기 때문에 
// 두 번째 구조체 인스턴스의 프로퍼티 값을 변경해도
// 첫 번째 구조체 인스턴스의 프로퍼티 값에는 영향이 없음
print("first struct instance property : \(firstStructInstance.property)")    // 1
print("second struct instance property : \(secondStructInstance.property)")  // 2


// 클래스 인스턴스 생성 후 첫 번째 참조 생성
let firstClassReference = ReferenceType()
// 두 번째 참조 변수에 첫 번째 참조 할당
let secondClassReference = firstClassReference
secondClassReference.property = 2

// 두 번째 클래스 참조는 첫 번째 클래스 인스턴스를 참조하기 때문에
// 두 번째 참조를 통해 인스턴스의 프로퍼티 값을 변경하면
// 첫 번째 클래스 인스턴스의 프로퍼티 값을 변경하게 됨
print("first class reference property : \(firstClassReference.property)")    // 2
print("second class reference property : \(secondClassReference.property)")  //