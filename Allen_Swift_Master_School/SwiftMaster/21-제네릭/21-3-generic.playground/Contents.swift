import UIKit


/*:
## 프로토콜에서의 제네릭 문법의 사용
* 프로토콜에서 제네릭의 사용 - Associated Types(연관 타입)
---
*/
/**================================================
 - 프로토콜을 제네릭 방식으로 선언하려면 어떻게 해야할까?
 - 연관타입(Assiciated Types)으로 선언해야함 ⭐️

 - 프로토콜은 타입들이 채택할 수 있는 한차원 높은 단계에서
   요구사항만을 선언(자격증)하는 개념이기 때문에
   제네릭 타입과 조금 다른 개념(연관타입)을 추가적으로 도입한 것 뿐
 
 [프로토콜 방식]
 - <T> ===> associatedtype T
 =================================================**/


protocol RemoteControl {           // <T>의 방식이 아님
    associatedtype T               // 연관형식은 대문자로 시작해야함(UpperCamelcase)
    func changeChannel(to: T)      // 관습적으로 Element를 많이 사용
    func alert() -> T?
}

/* 공식문서는 이렇게 Element 라고 이름 붙어있을 것임
 protocol RemoteControl {
     associatedtype Element
     func changeChannel(to: Element)
     func alert() -> Element?
 }
 */

/*
 즉 프로토콜(자격증)에서 어떤 타입을 정의할때 미리 타입을 정의하지 않는 것임
 이런식으로 요구사항을 선언해 놓으면 채택하는 타입에서 타입에 대한 정의를 구체적으로 한다음에 사용할 수 있음
 그래서 이 프로토콜 자체도 유연성이 넓어 진다는 것임
 중요 포인트는 그래서 프로토콜에서 제네릭 문법을 사용할때는
 associatedtype T 이와 같은 형식을 블럭안에 넣어서 사용해야 하는 것임
 */



// 연관형식이 선언된 프로토콜을 채용한 타입은, typealias로 실제 형식을 표시해야함

// typealias Number = Int       인트를 넘버라는 이름으로 사용하겠다고 할때 이용하는 문법이라고 배웠었음
struct TV: RemoteControl {
    
    //typealias T = Int       // 생략 가능
    
    /*
     프로토콜에서 모든 타입이 올수 있다고 했는데 실제 채택해서 정의할때는 구체적인 타입을 정의해줘야함
     프로토콜에서는 추상 단계고 채택했을 때는 구체적 단계니까
     typealias T = Int 위에서 정의한 T를 인트형으로 사용하겠다고 말하고 아래를 다 Int 이렇게 바꿔줘야함
     생략 가능해서 그냥 아래처럼 구체적으로 타입을 넣어줘도 됨
     */
    func changeChannel(to: Int) {   // 자격증을 채택하면 요구하는 메서드 구현해줘야함 + 연관타입을 구체적 타입으로 명시
        print("TV 채널바꿈: \(to)")
    }
    
    func alert() -> Int? {
        return 1
    }

}



class Aircon: RemoteControl {

    // 연관형식이 추론됨
    
    func changeChannel(to: String) {
        print("Aircon 온도바꿈: \(to)")
    }

    func alert() -> String? {
        return "1"
    }

}

// 제네릭이라 문자열로 구현해도 상관 없음

/*:
---
* 연관 형식에 제약을 추가한다면
---
*/
// Equatable 프로토콜을 채택한 타입만 가능해라고 정의가능

protocol RemoteControl2 {
    associatedtype Element: Equatable     // <T: Equatable> 제약조건 추가
    func changeChannel(to: Element)
    func alert() -> Element?
}

/*
 즉 이 프로토콜을 채택하고 구체화 할때 Element 타입은 Equatable 프로토콜을 채택한 타입만 가능해라고 제약을 추가 한것임
 */







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
