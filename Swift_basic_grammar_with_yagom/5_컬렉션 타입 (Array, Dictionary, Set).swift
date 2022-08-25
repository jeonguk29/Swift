/* 
컬렉션 타입 (Array, Dictionary, Set)
컬렉션 타입은 여러 변수들을 묶거나 값들을 묶어서 하나의 변수로 표현 할수 있게 해줌



Array	순서가 있는 리스트 컬렉션
Dictionary	키와 값의 쌍으로 이루어진 컬렉션
Set	순서가 없고, 멤버가 유일한 컬렉션 (중복값 x)

*/


/*
Array
Array는 멤버가 순서(인덱스)를 가진 리스트 형태의 컬렉션 타입입니다.
Array 선언 및 생성
Array는 여러 리터럴 문법을 활용할 수 있어서 표현 방법이 다양합니다
*/

// 빈 Int Array 생성
var integers: Array<Int> = Array<Int>()

// 같은 표현
// var integers: Array<Int> = [Int]()
// var integers: Array<Int> = []
// var integers: [Int] = Array<Int>()
// var integers: [Int] = [Int]()
// var integers: [Int] = []
// var integers = [Int]()
// Array 활용

integers.append(1)
integers.append(100)

// Int 타입이 아니므로 Array에 추가할 수 없습니다
//integers.append(101.1)

print(integers)	// [1, 100]


// 멤버 포함 여부 확인
print(integers.contains(100)) // true
print(integers.contains(99)) // false

// 멤버 교체
integers[0] = 99

// 멤버 삭제
integers.remove(at: 0) // 0 번 인덱스 삭제 
integers.removeLast() // 마지막 인덱스 삭제
integers.removeAll() // 전체 인덱스 삭제 

// 멤버 수 확인
print(integers.count)

// 인덱스를 벗어나 접근하려면 익셉션 런타임 오류발생
//integers[0]  현제 값이 없으니까 


//let을 사용하여 Array를 선언하면 불변 Array가 됩니다

let immutableArray = [1, 2, 3]

// 수정이 불가능한 Array이므로 멤버를 추가하거나 삭제할 수 없습니다
//immutableArray.append(4)
//immutableArray.removeAll()



/*
Dictionary
Dictionary는 키와 값의 쌍으로 이루어진 컬렉션 타입입니다.

Dictionary의 선언과 생성

Dictionary는 여러 리터럴 문법을 활용할 수 있어서 표현 방법이 다양합니다
*/
// Key가 String 타입이고 Value가 Any(어떤타입이던)인 빈 Dictionary 생성
var anyDictionary: Dictionary<String, Any> = [String: Any]()

// 같은 표현
// var anyDictionary: Dictionary <String, Any> = Dictionary<String, Any>()
// var anyDictionary: Dictionary <String, Any> = [:]
// var anyDictionary: [String: Any] = Dictionary<String, Any>()
// var anyDictionary: [String: Any] = [String: Any]()
// var anyDictionary: [String: Any] = [:]
// var anyDictionary = [String: Any]()

//Dictionary 활용


// 키에 해당하는 값 할당
anyDictionary["someKey"] = "value"
anyDictionary["anotherKey"] = 100

print(anyDictionary) // ["someKey": "value", "anotherKey": 100]

// 키에 해당하는 값 변경
anyDictionary["someKey"] = "dictionary"
print(anyDictionary) 
//["someKey": "dictionary", "anotherKey": 100]

// 키에 해당하는 값 제거
anyDictionary.removeValue(forKey: "anotherKey")
anyDictionary["someKey"] = nil  // 닐 사용해서 넣어주면 제거가 됨 
print(anyDictionary)


//let을 사용하여 Dictionary를 선언하면 불변 Dictionary가 됩니다

let emptyDictionary: [String: String] = [:]
let initalizedDictionary: [String: String] = ["name": "yagom", "gender": "male"]

// 불변 Dictionary이므로 값 변경 불가
//emptyDictionary["key"] = "value"


//키에 해당하는 값을 다른 변수나 상수에 할당하고자 할 때는 옵셔널과 타입 캐스팅 파트에서 다룹니다

//let someValue: String = initalizedDictionary["name"]
// "name"이라는 키에 해당하는 값이 없을 수 있으므로 
// String 타입의 값이 나올 것이라는 보장이 없습니다.
// 컴파일 오류가 발생합니다




/*
Set
Set는 순서가 없고, 멤버가 유일한 것을 보장하는 컬렉션 타입입니다.

Set의 선언과 생성 
Set은 참고로 축약 문법이 없음 


*/
// 빈 Int Set 생성
var integerSet: Set<Int> = Set<Int>()
integerSet.insert(1)
integerSet.insert(100)
integerSet.insert(99)
integerSet.insert(99)
integerSet.insert(99)

print(integerSet) // [100, 99, 1] (중복 허용 안해서 )
print(integerSet.contains(1)) // true  // 안에 값이 있는지 확인 
print(integerSet.contains(2)) // false

// 값 삭제 
integerSet.remove(100)
integerSet.removeFirst()

print(integerSet.count) // 1





//Set는 집합연산에 많이 활용됩니다

// Set는 집합 연산에 꽤 유용합니다
let setA: Set<Int> = [1, 2, 3, 4, 5]
let setB: Set<Int> = [3, 4, 5, 6, 7]

// 합집합
let union: Set<Int> = setA.union(setB)
print(union) // [2, 4, 5, 6, 7, 3, 1]

// 합집합 오름차순 정렬
let sortedUnion: [Int] = union.sorted()  // 배열로 담아줌 
print(sortedUnion) // [1, 2, 3, 4, 5, 6, 7]

// 교집합
let intersection: Set<Int> = setA.intersection(setB)
print(intersection) // [5, 3, 4]

// 차집합
let subtracting: Set<Int> = setA.subtracting(setB)
print(subtracting) // [2, 1]