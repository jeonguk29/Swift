/*
클로저는 코드의 블럭입니다.
일급시민(first-citizen)으로, 전달인자, 변수, 상수 등으로 저장, 전달이 가능합니다.
함수는 클로저의 일종으로, 이름이 있는 클로저라고 생각하면 됩니다.




기본 클로저 문법
{ (매개변수 목록) -> 반환타입 in
    실행 코드
}

매개 변수 필요없으면 () 로만 사용해도 됨 반환타입 없으면 void 사용


*/
// 함수를 사용한다면 
func sumFunction(a: Int, b: Int) -> Int {
    return a + b
}


var sumResult: Int = sumFunction(a: 1, b: 2)

print(sumResult) // 3


//클로저의 사용
// sum이라는 변수에 클로저를 할당
var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
}


sumResult = sum(1, 2)
print(sumResult) // 3  : 함수를 사용한 것과 완전 동일함 

// 함수는 클로저의 일종이므로
// sum 변수에는 당연히 함수도 할당할 수 있습니다.

sum = sumFunction(a:b:)

sumResult = sum(1,2) // sumFunction(a:b:) 호출이 되는 것임
print(sumResult)


/*
함수의 전달
인자로서의 클로저
클로저는 주로 함수의 전달인자로 많이 사용됩니다. 
함수 내부에서 원하는 코드블럭을 실행할 수 있습니다.
*/

let add: (Int, Int) -> Int
add = { (a: Int, b: Int) -> Int in
    return a + b  // add 상수에 클로저 할당 
}

let substract: (Int, Int) -> Int
substract = { (a: Int, b: Int) -> Int in
    return a - b
}

let divide: (Int, Int) -> Int
divide = { (a: Int, b: Int) -> Int in
    return a / b
}

// calculate 라는 함수에 method라는 이름으로 클로저를 넘겨줌 
func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b) // 함수에서 전달 받은 클로저를 호출 
}


var calculated: Int

calculated = calculate(a: 50, b: 10, method: add)

print(calculated) // 60

calculated = calculate(a: 50, b: 10, method: substract)

print(calculated) // 40

calculated = calculate(a: 50, b: 10, method: divide)

print(calculated) // 5

//따로 클로저를 상수/변수에 넣어 전달하지 않고, 
//함수를 호출할 때 클로저를 작성하여 전달할 수도 있습니다.

calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
    return left * right
})

print(calculated) // 500

