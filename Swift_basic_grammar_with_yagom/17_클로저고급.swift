/* 
클로저 표현이 한줄에 너무 여러 표현 들어가서 손쉽게 표현 할수 있는 방법 있음
너무나 다양한 표현이 있기 때문에 적당한 선에서 축약 문법 사용하는게 좋음

클로저 고급 

후행 클로저
반환타입 생략
단축 인자이름
암시적 반환 표현 



*/



//MARK: - 후행 클로저
// 클로저가 함수의 마지막 전달인자라면
// 마지막 매개변수 이름을 생략한 후
// 함수 소괄호 외부에 클로저를 구현할 수 있습니다

// calculate 라는 함수에 method라는 이름으로 클로저를 넘겨줌 
func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b) // 함수에서 전달 받은 클로저를 호출 
}

var result: Int


result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}  
// 함수에method 까지 넣어야하는데 )로 끝남 뒤에 클로저 저렇게 쓰면 저 클로저까지 마지막 전달인자로 
// 전달하겠다는 뜻임


print(result) // 20


//MARK: - 반환타입 생략
// calculate 함수의 method 매개변수는
// Int 타입을 반환할 것이라는 사실을 컴파일러도 알기 때문에
// 굳이 클로저에서 반환타입을 명시해 주지 않아도 됩니다
// 대신 in 키워드는 생략할 수 없습니다

result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) in  // -> Int in 이걸 축약 가능 하다는 것임 함수에 반환타입 뭐라고 지정했으니까
    return left + right
})

print(result) // 20

// 후행클로저와 함께 사용할 수도 있습니다
result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
    return left + right
}


//MARK: - 단축 인자이름
// 클로저의 매개변수 이름이 굳이 불필요하다면 단축 인자이름을 활용할 수 있습니다
// 단축 인자이름은 클로저의 매개변수의 순서대로 $0, $1... 처럼 표현합니다

result = calculate(a: 10, b: 10, method: {
    return $0 + $1 // 매개변수 목록이 없는데도 불구하고 left + right 대신 사용 가능
    //매개변수 타입도 컴파일러가 알고 있어서 이렇게 사용 가능 한거암 
    // 인트타입 첫번째 매개변수 인트타입 두번째 매개변수 이렇게 표현 가능한거임
    // in도 생략 됨 

})

print(result) // 20

// 당연히 후행 클로저와 함께 사용할 수 있습니다
result = calculate(a: 10, b: 10) {
    return $0 + $1
}

print(result) // 20


//MARK: - 암시적 반환 표현
// 클로저가 반환하는 값이 있다면
// 클로저의 마지막 줄의 결과값은 암시적으로 반환값으로 취급합니다

result = calculate(a: 10, b: 10) {
    $0 + $1   // 즉 return 키워드 생략해도 반환해줌
}

print(result) // 20

// 간결하게 한 줄로 표현해 줄 수도 있습니다
result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20

// 축약하지 않은 클로저 문법과 축약 후의 문법 비교

result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) -> Int in
    return left + right
})

result = calculate(a: 10, b: 10) { $0 + $1 }

print(result) // 20

// 너무 축약해서 쓰면 다른 사람이 이해 할수 없을수도 있어서 적정 선이 필요함 협업할때는
