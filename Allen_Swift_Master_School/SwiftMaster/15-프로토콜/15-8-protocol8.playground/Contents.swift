import UIKit


/*:
 ## 6) 프로토콜 확장의 적용 제한
 * (전 강의에서 다룬)프로토콜의 확장
 ---
 */
protocol Remote {
    func turnOn()        // 요구사항
    func turnOff()       // 요구사항
}


extension Remote {
    func turnOn() { print("리모콘 켜기") }
    func turnOff() { print("리모콘 끄기") }
}


/*:
 ---
 * 프로토콜 확장 - 형식을 제한 가능
 ---
 */
protocol Bluetooth {
    func blueOn()
    func blueOff()
}

/**====================================================
 - 프로토콜 확장에서 where절을 통해, 프로토콜의 확장의 적용을 제한 가능
 - "특정 프로토콜"을 채택한 타입에만 프로토콜 확장이 적용되도록 제한
    where Self: 특정프로토콜
 
 - 특정 프로토콜을 채택하지 않으면, 프로토콜의 확장이 적용되지 않기 때문에
   (확장이 없는 것과 동일하게) 메서드를 직접구현 해야함
=======================================================**/


// 특정 프로토콜을 채택한 타입에만 프로토콜 확장이 적용되도록 제한
// (Remote 프로토콜을 채택한 타입만 확장 적용 가능)
extension Bluetooth where Self: Remote {   // 본 확장의 적용을 제한시키는 것 가능 (구체적 구현의 적용범위를 제한)
    func blueOn() { print("블루투스 켜기") }
    func blueOff() { print("블루투스 끄기") }
}// Self 는 자기자신에 타입자체를 의미 Remote 타입을 채택하지 않으면 Bluetooth의 확장을 이용 할 수 없음
// 채택하더라도 내가 구현해야함


// Remote프로토콜을 채택한 타입만 Bluetooth 확장이 적용됨
// Remote프로토콜을 채택하지 않으면 ===> 확장이 적용되지 않기 때문에 직접 구현 해야함
class SmartPhone: Remote, Bluetooth {
    
    
}


class SmartPhone2: Bluetooth {
    func blueOn() { print("블루투스 켜기 직접 구현") }
    func blueOff() { print("블루투스 끄기 직접 구현") }
    
}



let sphone = SmartPhone()
sphone.turnOn()           // 리모콘 켜기
sphone.turnOff()          // 리모콘 끄기
sphone.blueOn()           // 블루투스 켜기
sphone.blueOff()          // 블루투스 끄기






/*
 객채지향 프로그래밍, 프로토콜 지향 프로그래밍, 함수형 프로그래밍 3가지 패러다임을 담고 있는언어임
 
 클래스와 상속의 단점
 1. 하나의 클래스만 상속가능 (다중 상속 불가능)
 2. 기본적인 상위클래스의 메모리 구조를 따라갈
 수 밖에 없음 (필요하지 않은 속성/메서드도 상속됨)
 3. 클래스(레퍼런스 타입)에서만 가능

 프로토콜 지향 프로그래밍
 1. 여러개의 프로토콜 채택 가능 (다중 상속과 유사)
 2. 메모리 구조에 대한 특정 요구사항 없음 
 (필요한 속성/메서드만 채택도 가능 - @optional)
 3. 모든 타입에서 채택 가능(밸류 타입도 가능)
 • 타입으로 사용가능하므로 활용성↑ + 확장성↑
 • 조합의 장점 잘 살려서, 보다 나은 구성/재사용성을 높일 수 있음
 • 프로토콜 지향 프로그래밍을 잘 사용하면, 애플이 이미 만들어 놓은 데이터타입에도 채택하여 활용 가능 (retroactive/소급적 적용 활용 가능)
 4. 확장에서 구체적정의(재정의 가능) (채택하는)타입 제약도 가능(where)
  
 + 프로토콜 테이블 같은 것도 만드니까 다형성같은 것도 활용 가능함 어떤 인스턴스에 따라서 어떤 메서드를 사용 할 것인지  이런것도 가능하니까
  즉 여러 타입에 따라서 다양한 메서드를 사용 할 수 있음
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
