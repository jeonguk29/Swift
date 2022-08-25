/*
매개변수 기본 값
매개변수에 기본적으로 전달될 값을 미리 지정할 수 있습니다

기본값을 갖는 매개변수는 매개변수 목록 중에 뒤쪽에 위치하는 것이 좋습니다

func 함수이름(매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 = 매개변수 기본값 ...) -> 반환타입 {
    /* 함수 구현부 */
    return 반환값
}

*/
func greeting(friend: String, me: String = "woogie") {
    print("Hello \(friend)! I'm \(me)")  
}

// 매개변수 기본값을 가지는 매개변수는 호출시 생략할 수 있습니다
greeting(friend: "hana") // Hello hana! I'm woogie
greeting(friend: "john", me: "eric") // Hello john! I'm eric


/*
전달인자 레이블
함수를 호출할 때 함수 사용자의 입장에서 매개변수의 역할을 좀 더 명확하게 표현하고자 할 때 사용합니다

func 함수이름(전달인자 레이블 매개변수1이름: 매개변수1타입, 전달인자 레이블 매개변수2이름: 매개변수2타입 ...) -> 반환타입 {
    /* 함수 구현부 */
    return
}

전달 인자 레이블을 사용하면 함수의 중복 정의도 손쉽게 사용 가능함
위에 greeting 라는 함수와 똑같은 타입과 , 메개변수를 가지는 함수지만 
to 와 from 이라는 전달인자를 사용해서 함수의 이름 자체가 바뀐 효과를 갖기 때문에
중복 정의로써의 역할 수행할수가 있음 
greeting 이라는 같은 이름을 가지고 있는것 처럼 보이지만 
실제로 swift에서는 함수의 이름이 greeting to from 까지 가 전부
함수의 이름으로 취급되서 위에 함수와 다른 함수로 취급됨 

*/

// 함수 내부에서 전달인자를 사용할 때에는 매개변수 이름을 사용합니다
func greeting(to friend: String, from me: String) {
    print("Hello \(friend)! I'm \(me)")
}

// 함수를 호출할 때에는 전달인자 레이블을 사용해야 합니다
greeting(to: "hana", from: "woogie") // Hello hana! I'm woogie


/*
가변 매개변수
전달 받을 값의 개수를 알기 어려울 때 사용할 수 있습니다

가변 매개변수는 함수당 하나만 가질 수 있습니다 (맨뒤 위치 하는게 좋음)

func 함수이름(매개변수1이름: 매개변수1타입, 전달인자 레이블 매개변수2이름: 매개변수2타입...) -> 반환타입 {
    /* 함수 구현부 */
    return
}
*/

func sayHelloToFriends(me: String, friends: String...) -> String {
    return "Hello \(friends)! I'm \(me)!"
}
print(sayHelloToFriends(me: "woogie", friends: "hana", "eric", "wing"))
// Hello ["hana", "eric", "wing"]! I'm woogie!

print(sayHelloToFriends(me: "woogie"))
// Hello []! I'm woogie!


// 아래와 같이 전달 인자가 없거나 nil 넣으면 오류가 남 
//print(sayHelloToFriends(me: "woogie", friends: nil))
//print(sayHelloToFriends(me: "woogie", friends: ))


/*
위에 설명한 함수의 다양한 모양은 모두 섞어서 사용 가능합니다

데이터 타입으로서의 함수
스위프트는 함수형 프로그래밍 패러다임을 포함하는 다중 패러다임 언어이므로 스위프트의 함수는 일급객체입니다. 그래서 함수를 변수, 상수 등에 할당이 가능하고 매개변수를 통해 전달할 수도 있습니다

그래서 swift의 
함수의 타입표현
반환타입을 생략할 수 없습니다.

(매개변수1타입, 매개변수2타입 ...) -> 반환타입
함수타입 사용
*/

var someFunction: (String, String) -> Void = greeting(to:from:)
someFunction("eric", "woogie") // Hello eric! I'm woogie

someFunction = greeting(friend:me:)
someFunction("eric", "woogie") // Hello eric! I'm woogie


// 타입이 다른 함수는 할당할 수 없습니다 - 컴파일 오류 발생
//someFunction = sayHelloToFriends(me: friends:) 현제 friends 가 가변 매개변수를 가져서 안됨



// 이렇게 함수 타입을 매개 변수 타입으로 지정을 해주면 
// function 이라는 매개변수를 안에서도 실행해줄수 있음 
// String 타입을 가지는 매개변수 2개함수이며 반환 값이 없는 함수가
// 이 매개변수의 타입이다
func runAnother(function: (String, String) -> Void) {
    function("jenny", "mike")
}

// Hello jenny! I'm mike
runAnother(function: greeting(friend:me:)) // 이렇게 함수를 넘겨줄수 있고


// Hello jenny! I'm mike
runAnother(function: someFunction) // 변수에 담아놓은 것을 넘겨 줄수도 있음


// 참고 : 스위프트의 전반적인 문법에서 띄어쓰기는 신경써야할 때가 많습니다