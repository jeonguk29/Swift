import UIKit


/*:
## 실패가능 생성자
 * 실패가능 생성자(Failable Initializers) - init?(파라미터)
 ---
 */
/**============================================================================
 - 실패가능 생성자는 인스턴스 생성에 실패할 수도 있는 가능성을 가진 생성자 (클래스, 구조체, 열거형 가능)
   (실패가 불가능하게 만들어서, 아예 에러가 나고 앱이 완전히 꺼지는 가능성보다는
    실패가능 가능성 생성자를 정의하고 그에 맞는 예외 처리를 하는 것이 더 올바른 방법임)

 - 생성자에 ?를 붙여서 init?(파라미터) 라고 정의하면 실패가능 생성자로 정의되는 것임
   (다만, 동일한 파라미터를 가진 생성자는 유일해야함. 오버로딩으로 실패가능/불가능을 구분 짓지 못함)
===============================================================================**/



struct Animal {
    let species: String
    
    // 실패가능 생성자
    init?(species: String) {
        //  init(species: String) -> Animal 우리가 생성자 만들때 이렇게 만들지 않음. 이렇게 하지 않아도 Animal. 인스턴스를 찍는걸 알고 있다고 약속 한것임 그렇기 때문에 init? 이러한 구조가 나오는 것임
        
        if species.isEmpty { // 문자열이 비어 있는 경우 species == ""
            return nil            // 생성자 내에서 실패 가능 부분에 nil을 리턴하면 됨  (문법적 약속)
        }
        self.species = species
    }
    
//    init(species: String) {    실패 가능자 생성시 이렇게 사용못함
//
//    }
    
}


let a = Animal(species: "Giraffe")    // ====> 인스턴스 생성

let b = Animal(species: "")           // 문자열이기에 유효한 타입이지만 =====> nil

// 옵션 누르고 확인 해보면 a는 옵셔널 Animal임 실패 가능하기 때문에

// 엄밀히 말하면 생성자는 값을 반환하지 않고, 초기화가 끝날 때까지 모든 저장 속성이 값을 가져 올바르게 초기화되도록하는 것임
// 초기화 성공을 나타 내기 위해 return 키워드를 사용하지 않음 (문법적 약속)

// 하지만 실패 가능생성자로 만든경우 실패했다고 nil을 반환해야해서 return 키워드 사용


/*:
---
* 열거형의 실패가능 생성자 활용
---
*/

enum TemperatureUnit {
    case kelvin
    case celsius
    case fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = TemperatureUnit.kelvin
        case "C":
            self = TemperatureUnit.celsius
        case "F":
            self = TemperatureUnit.fahrenheit
        default:
            return nil
        }
    }
}


let c: TemperatureUnit = TemperatureUnit.celsius      // TemperatureUnit()
// 열거형은 이렇게 해주는 것도 인스턴스를 찍는 즉 생성하는 방법이라고 했음 이렇게 생성하는 경우는 옵셔널 타입이 아님
let f: TemperatureUnit? = TemperatureUnit(symbol: "F")
// 이렇게 실패가능 생성자를 통해 생성하는 경우 실패 할 수 있기 때문에 옵셔널 타입임


// 열거형의 원시값 설정 (실패가능 생성자의 구현과 유사)

enum TemperatureUnit1: Character {
    case kelvin = "K"
    case celsius = "C"
    case fahrenheit = "F"
}


// 원시값이있는 열거형은 자동으로 실패가능 생성자 init?(rawValue :)를 구현함 ==> 일치하면 인스턴스 생성, 아니면 nil

 
let f1: TemperatureUnit1? = TemperatureUnit1(rawValue: "F")     // .fahrenheit

let u: TemperatureUnit1? = TemperatureUnit1(rawValue: "X")      // nil


// 즉 열거형에서 실패가능 생성자를 이용하여 구현 한것과 원시값을 이용하여 구현한것은 아주 유사함

/*:
---
* 1) 초기화 실패의 전달 (호출관계)
---
*/
/**============================================================
 - (한마디로) 실패불가능 생성자는 다른 실패가능 생성자를 호출 불가능 ⭐️
 
 (동일단계 - 델리게이트 어크로스)
 - 실패가능  ===> 실패불가능  (호출/위임) (OK)
 - 실패불가능 ===> 실패가능   (호출/위임) (X)
 
 (상속관계 - 델리게이트 업)
 - (상위)실패가능  <=== (하위)실패불가능  (호출/위임)  (X)
 - (상위)실패불가능 <=== (하위)실패가능   (호출/위임)  (OK)
 

 - 두 경우 모두 초기화 실패를 유발하는 다른 생성자에 위임하면
 - 전체 초기화 프로세스가 즉시 실패하고 더 이상 초기화 코드가 실행되지 않음
==============================================================**/


struct Item {
    var name = ""
    
    init(){
        // self.init() 이건 불가능함  실패불가능 생성자에서 실패가능 생성자 호출 못함
    }
    
    init?(name:String){
        self.name = name
        self.init() // 이런식으로 실패가능 생성자에서  ===> 실패불가능 생성자 호출가능함
    }
}
// 이러한 이유는 잘 생각해 보면 이해할 수 있음 ex Int? 범위 안에 Int, nil 들어가 있음 범위로 봤을때 더 큰 범위에서 작은 범위 접근 가능하지만 작은 범위에서 큰범위 호출 못하는 개념임
// 이개념은 상속 관계에서도 똑같음 이거 하나만 생각하면됨 어떤게 더 큰범위 인지 어떤게 더 작은 범위인지
// 호출도 범위 생각하기
/*
 실패 가능 => 실패가능 : ok
 실패 가능 => 실패 불가능 : ok
 실패 불가능 => 실패 가능 : no
 */


// 상속관계에서의 호출 예제

// 상품

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


// 온라인 쇼핑 카트의 항목을 모델링

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }     // 상품의 갯수가 1보다 작으면 ====> 카트 항목 생성 실패
        self.quantity = quantity           // 수량이 한개 이상이면 ====> 초기화 성공
        super.init(name: name)             // "" (빈문자열이면)  ====> 실패 가능 위임 OK
    }                                      // 또 위로 올라가서 빈 문자열이면 nil반환 할 것임
}



if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("아이템: \(twoSocks.name), 수량: \(twoSocks.quantity)")
}



if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("아이템: \(zeroShirts.name), 수량: \(zeroShirts.quantity)")
} else {
    print("zero shirts를 초기화 불가(갯수가 없음)")
}



if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("아이템: \(oneUnnamed.name), 수량: \(oneUnnamed.quantity)")
} else {
    print("이름없는 상품 초기화 불가")
}




/*:
---
* 2) (상속관계에서) 재정의 하기
---
*/
/**===============================================================
 - (상위)실패가능  ===> (하위)실패불가능  재정의 (OK)  (강제 언래핑 활용 가능)
 - (상위)실패불가능 ===> (하위)실패가능   재정의  (X)
 ===============================================================**/
//:> 범위로 따져보기(실패가능 생성자의 범위가 더 큼)


// 서류라는 클래스 정의

class Document {
    
    var name: String?
    
    init() {}                // 서류 생성 (실패불가능) (이름은 nil로 초기화)
    
    init?(name: String) {    // 실패가능 생성자 ===> 이름이 "" 빈문자열일때, 초기화 실패(nil)
        if name.isEmpty { return nil }
        self.name = name
    }
}


// 자동으로 이름지어지는 서류

class AutomaticallyNamedDocument: Document {
    
    override init() {                // 재정의 (상위) 실패불가능 =====> (하위) 실패불가능
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {    // 재정의 (상위) 실패가능 =====> (하위) 실패불가능
        super.init()                 // 실패불가능 활용가능
        
        // 즉 실패 가능을 재정의 하면서 내부에서는 실패 불가능 생성자를 호출
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
/*
 현재 지정생성자 2개를 재정의 하고 있음 하나 차이점 실패 가능 생성자에서  override init(name: String)  실패 불가능 생성자로 정의함
 */

let autoDoc = AutomaticallyNamedDocument(name: "")
autoDoc.name



// 이름없는(Untitled) 서류

class UntitledDocument: Document {
    
    override init() {               // 재정의 (상위) 실패가능 =====> (하위) 실패불가능
        //super.init()
        super.init(name: "[Untitled]")!    // 강제 언래핑(!)으로 구현 ⭐️
        // 이렇게 해주면 nil 나올 가능성이 없으니까
        
        /*
         실패가능 생성자 관련해서 질문이있습니다. 상위의 실패 불가능생성자가 하위에서 실패 불가능 생성자로 재정의 되었을 때 그 안에서 상위의 실패 가능생성자를 호출하는 것이 예제에서 가능한 것 처럼 보이는데요, 원래 호출관계에서는 하위의 실패 불가능 생성자에서 상위의 실패 가능생성자를 호출할 수 없는 것이 규칙인데 재정의가 된 생성자에서는 이 규칙이 적용되지 않는 건가요?
         
         호출관계에서는
         하위의 실패 불가능 생성자 ===> 상위의 실패 가능생성자를 호출 하는 것이 불가능
         하다고 앞의 내용에서 말씀드리긴 하는데,
         (실제로 호출해서, 인스턴스를 생성하려고 하는 것은 당연히 불가능하고.. 호출해서 결론적으로 인스턴스를 생성하려는 것이니.. 어떻게 보면, 예외적으로)

         강제 언래핑을 통해서 실질적으로 옵셔널의 상황(즉, nil을 리턴할 수도 있는 실패 가능한 상황)이 안나오도록 (실질적 코드 구현으로 가능성을 없앰) 구현하는 것은 가능하다는 뜻이라고 보시면 될 것 같습니다.

         즉, 실질적인 코드구현은 !(강제언래핑)를 붙이고, 내부 코드가 super.init(name: "[Untitled]")! 이런 방식으로 재정의로 구현해서, 실패해서 nil을 리턴하는 상황을 아예 없애버린 것이죠.
         (그냥 예외적으로 코드구현을 통해, 호출이 가능한 상황을 만들어 주었다고 생각하시면 될 것 같긴해요.)
         */
    }
}





/*:
---
* 실패가능 생성자를 init!(파라미터)로 정의하기
---
*/
/**=========================================================================
 - 일반적으로 init 키워드 (init?) 뒤에 물음표를 배치하여 적절한 유형의 선택적 인스턴스를 생성하는
   실패 가능한 이니셜 라이저를 정의함. 또는 적절한 유형의 암시적으로 래핑되지 않은 선택적
   인스턴스를 만드는 실패 가능한 이니셜 라이저를 정의 할 수 있음.
   
 - 물음표 대신 init 키워드 (init!) 뒤에 느낌표

  ================================
 - init? ====> init! 위임 가능
 - init! ====> init? 위임 가능

 - init? ====> init! 로 재정의 가능
 - init! ====> init? 로 재정의 가능
 =================================


 - init ====> init! 위임 가능 (실패할 수도 있어짐) ⭐️
=============================================================================**/

// 그냥 init? == init! 두개가 동일하다 라고 생각해도 무방함 어떻게 쓰던 상관 없는 것임
// 크게 중요 x





//Copyright (c) 2021 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
