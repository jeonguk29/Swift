/*
for-in 구문
기존 언어의 for-each 구문과 유사합니다. Dictionary의 경우 이터레이션 아이템으로 튜플이 들어옵니다. 튜플에 관해서는 Swift Language Guide의 Tuples 부분을 참고하면 되겠습니다.

for-in 구문의 기본 형태
for item in items {
    /* 실행 구문 */
}
*/

for-in 구문의 사용
var integers = [1, 2, 3]
let people = ["yagom": 10, "eric": 15, "mike": 12]

for integer in integers {
    print(integer)
}

// Dictionary의 item은 key와 value로 구성된 튜플 타입입니다
for (name, age) in people {
    print("\(name): \(age)")  // 튜플 타입이 들어오기 때문에 name자리레 key, value 자리에 value가 들어오게됨
}

/*
while 구문
while 구문의 기본 형태
while 조건 {
    /* 실행 구문 */
}

*/

// while 구문의 사용
while integers.count > 1 {  //() 소괄호는 선택 사항 
    integers.removeLast()
}


/*
repeat-while 구문
기존 언어의 do-while 구문과 형태 및 동작이 유사합니다


repeat-while 구문의 기본 형태
repeat {
    /* 실행 구문 */
} while 조건
repeat-while 구문의 사용
*/

repeat {
    integers.removeLast()  // 이부분이 먼저 실행 된 이후에
} while integers.count > 0  // 이부분 조건 체크후 계속 반복 됨

// do 키워드가 사용 되지 않는 이유는 do 키워드가 swift에 오류 처리 구문에서 사용되기 때문임
