/*
assert와 guard

애플리케이션이 동작 도중에 생성하는 다양한 연산 결과값을 동적으로 확인하고 
안전하게 처리할 수 있도록 확인하고 빠르게 처리할 수 있습니다.


*/


// Assertion
// assert(_:_:file:line:) 함수를 사용합니다. 
// assert 함수는 디버깅 모드에서만 동작합니다.
// 배포하는 애플리케이션에서는 제외됩니다. 
// 주로 디버깅 중 조건의 검증을 위하여 사용합니다.
// 내가 예상 했던 조건들이 확실히 맞는가 검증하기 위해 사용함


var someInt: Int = 0
// 검증 조건에 부합하므로 지나갑니다
assert(someInt == 0, "someInt != 0") // 맞으면 지나치고 아니면 someInt != 0 메세지 출력


someInt = 1
//assert(someInt == 0) // 동작 중지, 검증 실패
//assert(someInt == 0, "someInt != 0") // 동작 중지, 검증 실패
// assertion failed: someInt != 0: file guard_assert.swift, line 26
// 메세지 부가적인거임 있어도 없어도 상관 x


func functionWithAssert(age: Int?) {
    
    assert(age != nil, "age == nil") // 매개변수 전달인자 값 확인할때도 사용 많이함
    // 닐이 들어올수 있는데 닐 이면 멈춤 
    
    assert((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다")
    // 그다음 나이 값 검증 

    print("당신의 나이는 \(age!)세입니다")// 모든거 통과 하면 실행 

}

functionWithAssert(age: 50)
//functionWithAssert(age: -1) // 동작 중지, 검증 실패
//functionWithAssert(age: nil) // 동작 중지, 검증 실패

//중요 !!!!!!!!!!!!!!   assert(_:_:file:line:)와 같은 역할을 하지만 실제 배포 환경에서도 동작하는 precondition(_:_:file:line:) 함수도 있습니다. 함께 살펴보세요.


/*
빠른 종료
Early Exit

guard를 사용하여 잘못된 값의 전달 시
특정 실행구문을 빠르게 종료합니다. 
디버깅 모드 뿐만 아니라 어떤 조건에서도 동작합니다. 
guard의 else 블럭 내부에는 특정 코드블럭을 종료하는 지시어(return, break 등)가 꼭 있어야 합니다. 빠른 종료를 하기 위한 거기 때문에
타입 캐스팅, 옵셔널과도 자주 사용됩니다. 
그 외에도 단순 조건 판단 후 빠르게 종료할 때도 용이합니다.
*/

func functionWithGuard(age: Int?) {
    
    guard let unwrappedAge = age, // guard let 하면 옵셔널 바인딩과 연결 시켜주는 것임
        unwrappedAge < 130,
        unwrappedAge >= 0   // 먼저 언 랩핑 (옵셔널 바인딩 바로 실행) 해서 옵셔널이면 바로 리턴함 그다음 이 조건들 부합하는 지 확인  
        else {
        print("나이값 입력이 잘못되었습니다") // 부합 하지 않으면 여기 실행 
        return // 이 함수 끝내버려라 
        // 리턴 명시 없으면 오류남 빠른 종료와 관련된 구문인데 왜 종료와 관련된 지시어 없다고 오류냄  
    }
    
    print("당신의 나이는 \(unwrappedAge)세입니다")
    // if let은 그 블럭 안에서만 사용 가능 했는데 guard let 은 밑에서도 사용 가능하게 해줌
}

var count = 1

while true {
    guard count < 3 else { // 반복문에서도 사용 가능 카운트 부합하지 않다면 종료시켜라
        break
    }
    print(count)
    count += 1
}
// 1
// 2



// 이렇게 딕셔너리 같은거 받아올때 굉장히 많이 활용됨 

func someFunction(info: [String: Any]) { 
    guard let name = info["name"] as? String else {
        return // 딕셔너리에서 나오는 값들은 모두 옵셔널임 현제 이 name 키에 관련된 값이 없기 때문
        // 이후 nil 아니면 케스팅 까지 (as? String == 스트링 타입인가?) 
        // 어떤것이 들어와도 상관 없는 String: Any  애니타입이기 때문임
        // 그래서 실질적으로 사용가능한지 String인지 한번더 캐스팅 까지 해서 응용 가능한거임
        // 번벽 동작시 name에 들어가고 아니면 종료됨 
    }
    
    guard let age = info["age"] as? Int, age >= 0 else {
        return
    }
    
    print("\(name): \(age)")
    
}

someFunction(info: ["name": "jenny", "age": "10"]) // 나이가int 타입 아니라 종료 
someFunction(info: ["name": "mike"]) // 아에 나이가 없어서 종료 (바인딩 케스팅도 안됨 )
someFunction(info: ["name": "woogie", "age": 10]) // woogie: 10