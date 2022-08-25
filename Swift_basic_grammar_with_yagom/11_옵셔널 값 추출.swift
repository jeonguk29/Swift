/*
옵셔널 값 추출 방법 2가지

• Optional Binding - 옵셔널 바인딩
• Force Unwrapping - 강제 추출


Optional Binding
옵셔널의 값을 꺼내오는 방법 중 하나
nil 체크 + 안전한 값 추출

ex 인트형을 보관하는 상자를 하나 더 보호막으로 감쌓아 준다고 생각하면됨
상자안에 값이 있습니까? 있으면 추출 없으면 지나침 
*/

//MARK:- Optional Binding

func printName(_ name: String) {  // 일반 스트링 값 가지려고 했는데
    print(name)
}

var myName: String? = nil

//printName(myName)
// 전달되는 값의 타입이 다르기 때문에 컴파일 오류발생


// 그래서 if-let 방식을 통해 옵셔널 바인딩 해줄수 있음 
//간단하게 말하면 if문 안의 조건문의 값이 nil인가 아닌가를 체크하는 문법입니다.
//조건문이 nill이 아니라면 해당 블럭이 실행되는 구조입니다.

if let name: String = myName {
    printName(name)
} else {
    print("myName == nil")
}


var yourName: String! = nil  // 암시적 추출 옵셔널 형식도 옵셔널 형태라 이런식으로 사용 가능함 

if let name: String = yourName {
    printName(name)
} else {
    print("yourName == nil")
}

// name 상수는 if-let 구문 내에서만 사용가능합니다
// 상수 사용범위를 벗어났기 때문에 컴파일 오류 발생
//printName(name)

// ,를 사용해 한 번에 여러 옵셔널을 바인딩 할 수 있습니다
// 모든 옵셔널에 값이 있을 때만 동작합니다
myName = "yagom"
yourName = nil

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}
// yourName이 nil이기 때문에 실행되지 않습니다

yourName = "hana"

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}
// yagom and hana         이렇게 값 할당하면 실행됨 



//MARK:- Force Unwrapping  옵셔널 강제 추출 방법
// 위에 옵셔널 바인딩은 보호막에 노크해서 정중하게 가져오고 지나가는 방식이라면
// 강제 추출 방식은 보호막을 깨 부시고 가져오는 방법임

func printName2(_ name: String) {  // 일반 스트링 값 가지려고 했는데
    print(name)
}

var myName2: String? = "woogie"
printName2(myName2!) // woogie  이렇게하면 강제로 옵셔널 ?벗겨지고 그 안에 값이 강제로 들어감
// 즉 옵셔널 타입이 아닌 스트링 타입으로 값 넘기는게 가능함 

myName2 = nil

//print(myName2!)
// 강제추출시 값이 없으므로 런타임 오류 발생

var yourName2: String! = nil
// 이 암시적 추출 옵셔널 형식은 선언 할때  myName2! 이런식으로
// 사용 할거다라는걸 가정하고 선언 함 

//printName(yourName2) 그래서 이렇게 쓰면 yourName2! 과 똑같은거임
// nil 값이 전달되기 때문에 런타임 오류발생

// 그래서 옵셔널 강제 추출 방식은 추천 되는 방식은 아님 안전하게 옵셔널 바인딩 방법 쓰자