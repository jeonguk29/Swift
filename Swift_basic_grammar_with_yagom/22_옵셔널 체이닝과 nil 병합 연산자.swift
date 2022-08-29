/*
옵셔널 체이닝

우리가 구조체, 클레스 선언해줄때 구조체 안에 구조체인스턴스 또 구조체 안에 구조체 인스턴스 이렇게 
연결 연결 되서 들어올수가 있음 
그런데 이 프러퍼티 자체가 옵셔널인 경우에는 이것이 nil인지 체크 해야 하는경우가 있는데
이럴때 옵셔널 체이닝이 유용하게 사용됨 

옵셔널 체이닝은 옵셔널의 내부의 내부의 내부로 옵셔널이 연결되어 있을 때 유용하게 활용할 수 있습니다.
매 번 nil 확인을 하지 않고 최종적으로 원하는 값이 있는지 없는지 확인할 수 있습니다.
*/
//예제 클래스
class Person {
    var name: String
    var job: String?
    var home: Apartment?
    
    init(name: String) {
        self.name = name
    }
}

class Apartment {
    var buildingNumber: String // 동
    var roomNumber: String // 호
    var `guard`: Person? // 경비원
    var owner: Person? // 집주인 
    
    init(dong: String, ho: String) {
        buildingNumber = dong
        roomNumber = ho
    }
}

// 옵셔널 체이닝 사용  
let woogie: Person? = Person(name: "woogie")
let apart: Apartment? = Apartment(dong: "101", ho: "202")
let superman: Person? = Person(name: "superman")
// 요렇게 필수 프로퍼티만 입력해주고 나머지는 아직 nil임 


// 옵셔널 체이닝이 실행 후 결과값이 nil일 수 있으므로
// 결과 타입도 옵셔널입니다

// 만약 우리집의 경비원의 직업이 궁금하다면..?

// 옵셔널 체이닝을 사용하지 않는다면...
func guardJob(owner: Person?) {
    if let owner = owner {
        if let home = owner.home {
            if let `guard` = home.guard {
                if let guardJob = `guard`.job {
                    print("우리집 경비원의 직업은 \(guardJob)입니다")
                } else {
                    print("우리집 경비원은 직업이 없어요")
                }
            }
        }
    }
}

guardJob(owner: woogie)

// 옵셔널 체이닝을 사용한다면
func guardJobWithOptionalChaining(owner: Person?) {

    // 요렇게 한번에 연결 가능 owner? 사람이 있나요? 있으면 
    // home? 사람의 집이 있나요? 있으면 사람의 집에 경비가 있나요? 
    // 사람의 집에 경비가 있다면 경비 직업이 있나요?
    // 만약 사람이 있나요? 에서 없으면 그냥 끝남 다음 단계로 넘어가지 않음

    if let guardJob = owner?.home?.guard?.job {
        print("우리집 경비원의 직업은 \(guardJob)입니다")
    } else {
        print("우리집 경비원은 직업이 없어요")
    }
}

guardJobWithOptionalChaining(owner: woogie)
// 우리집 경비원은 직업이 없어요



woogie?.home?.guard?.job // nil
// 집이 할당 없음 
woogie?.home = apart // 집 할당 

woogie?.home // Optional(Apartment)
woogie?.home?.guard // nil
// 경비가 없음 

woogie?.home?.guard = superman // 경비 할당 

woogie?.home?.guard // Optional(Person)

woogie?.home?.guard?.name // superman

// 경비원 직업 없음 
woogie?.home?.guard?.job // nil

woogie?.home?.guard?.job = "경비원"

/*
nil 병합 연산자
중위 연산자입니다. ??

Optional ?? Value

옵셔널 값이 nil일 경우, 우측의 값을 반환합니다. 
띄어쓰기에 주의하여야 합니다.
*/
var guardJob: String
    
guardJob = woogie?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) // 경비원

woogie?.home?.guard?.job = nil

guardJob = woogie?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) // 슈퍼맨
