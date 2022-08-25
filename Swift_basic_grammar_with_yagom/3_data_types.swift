/* 기본 데이터 타입 */


// Swift의 기본 데이터 타입
// Bool, Int, UInt, Float, Double, Character, String

// Swift는 데이터 타입에 엄청 엄격한 언어임 
// 다른 데이터 타입 간에 자료 교환이 까다로음 
// 사실상 다른 데이터 타입과 자료 교환 거의 불가능 하다고 생각하면 됨

// Bool
var someBool: Bool = true
someBool = false
// c언어및 다른 언어에서 0, 1을 Bool 타입에 넣으면 오류남 
// someBool = 0 // 컴파일 오류발생       
// someBool = 1 // 컴파일 오류발생



// Int
var someInt: Int = -100
// someInt = 100.1 // 컴파일 오류발생
// Int 타입에는 Int만 가능 


// UInt
var someUInt: UInt = 100
// someUInt = -100 // 컴파일 오류발생
// someUInt = someInt // 컴파일 오류발생

// Float
var someFloat: Float = 3.14
someFloat = 3

// Double
var someDouble: Double = 3.14
someDouble = 3
// someDouble = someFloat // 컴파일 오류발생  더들 타입에 float 타입은 못들어감 정수는 가능하지만 

// Character
var someCharacter: Character = "🇰🇷"
someCharacter = "😄"
someCharacter = "가"
someCharacter = "A"
// someCharacter = "하하하" // 컴파일 오류발생 : 한문자가 아닌 여러 글자로 넣으면 오류 발생 
print(someCharacter)

// String
var someString: String = "하하하 😄 "
someString = someString + "웃으면 복이와요"  // 연산자를 이용해 문자열을 더할수도 있음 
print(someString)

// someString = someCharacter // 컴파일 오류발생  : 하나의 문자 문자열 타입에 못 넣음 

someString = """
여러줄 문자열을
사용할 수 있습니다.
첫 줄에 겹따옴표 세 개,
마지막 줄에 겹따옴표 세 개를
사용하면 됩니다.
"""

someString = """
겹따옴표 세 개인 줄(첫줄, 끝줄)에서
줄 바꿈을 하지 않으면 오류가 발생합니다.
"""

/*
someString = """오류발생
오류발생"""
*/
