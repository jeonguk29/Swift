/*
이름짓기 규칙
Lower Camel Case  (소문자)
fuction, method, variable, constant
    ex someVariableName

Upper Camel Case (대문자)
type(class, struct, enum, extension…)

    ex Person, Point, Week

Swift는 모든 대소문자를 구분합니다.


콘솔로그 남기기위한 방법2

print 함수 : 단순 문자열 출력

dump 함수 : 클레스의 인스턴스의 자세한 설명(description 프로퍼티)까지 출력

문자열 보관법 : String Interpolation  => 프로그램 실행 중 문자열 내에 변수 또는 상수의 실질적인 값을 표현하기 위해 사용합니다.
    ex  \()

*/

let age: Int = 10

//"안녕하세요! 저는 \(age)살입니다"
// == "안녕하세요! 저는 10살입니다"

//"안녕하세요! 저는 \(age + 5)살입니다"
// == "안녕하세요! 저는 15살입니다"

print("안녕하세요! 저는 \(age + 5)살입니다")

print("\n####################\n")

class Person {
    var name: String = "yagom"
    var age: Int = 10
}

let yagom: Person = Person()

print(yagom)

print("\n####################\n")

dump(yagom)  // 복잡한 클레스 인스턴스, 구조체 인스턴스 표현할때 좋음 print와 결과가 다름 
// 자세하게 어떤 값 들어있는지 확인 가능 