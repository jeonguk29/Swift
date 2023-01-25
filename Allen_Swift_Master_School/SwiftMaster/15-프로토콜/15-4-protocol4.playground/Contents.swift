import UIKit


/*:
 ## 3-1) 타입으로써의 프로토콜(Protocols as Types)
 * 프로토콜은 타입이다.
 ---
 */
//:> 프로토콜은 타입
// 프로토콜은 ===> First Class Citizen(일급객체)이기 때문에, 타입(형식)으로 사용할 수 있음


protocol Remote {
    func turnOn()
    func turnOff()
}


class TV: Remote {
    func turnOn() {
        print("TV켜기")
    }
    
    func turnOff() {
        print("TV끄기")
    }
}


struct SetTopBox: Remote {
    func turnOn() {
        print("셋톱박스켜기")
    }
    
    func turnOff() {
        print("셋톱박스끄기")
    }
    
    func doNetflix() {
        print("넷플릭스 하기")
    }
}

//let tvtype: TV = TV()
//let sboxtype: SetTopBox = SetTopBox()
/*
 현재 각 변수에는 각각의 클래스와 구조체로 찍은 타입인걸 알 수 있지만 클래스에서 상위클래스로 업캐스팅 해서 저장한것 처럼
 아래와 같이 프로토콜 타입으로 저장이 가능해진다는 것임 주의 해야할건 이렇게 프로토콜 타입으로 저장하면
 프로토콜 타입에서 선언한 메서드만 호출이 가능함
 
 */
let tvtype: Remote = TV()
let sboxtype: Remote  = SetTopBox()


let tv: Remote = TV()
tv.turnOn()
tv.turnOff()


let sbox: Remote = SetTopBox()
sbox.turnOn()
sbox.turnOff()
//sbox.doNetflix()


// 우리가 타입캐스팅에서 배운 다운캐스팅을 여기서도 사용할수 있음
(sbox as? SetTopBox)?.doNetflix()
// 다운캐스팅 성공시 doNetflix() 메서드 실행
(sbox as! SetTopBox).doNetflix()
// 강제 다운 캐스팅시 이런식으로 구현
/*:
 ---
 * 프로토콜 타입 취급의 장점
 ---
 */
// 프로토콜의 타입 취급의 장점 - 1 ⭐️

let electronic: [Remote] = [tv, sbox]      // 프로토콜의 형식으로 담겨있음


for item in electronic {   // 켜기, 끄기 기능만 사용하니 타입캐스팅을 쓸 필요도 없음 (다만, 프로토콜에 있는 멤버만 사용가능)
    item.turnOn()
}




// 프로토콜의 타입 취급의 장점 - 2 ⭐️

func turnOnSomeElectronics(item: Remote) { // 함수의 타입으로도 프로토콜 사용 가능
    item.turnOn()
}

turnOnSomeElectronics(item: tv)
turnOnSomeElectronics(item: sbox)


/*:
 ---
 * 프로토콜 준수성 검사
 ---
 */
/**==================================================================================
 - is / as 연산자 사용가능

 - is 연산자 ===> 특정 타입이 프로토콜을 채택하고 있는지 확인 (참 또는 거짓) / 그 반대도 확인가능
 - as 연산자 ===> 타입 캐스팅 (특정 인스턴스를 프로토콜로 변환하거나, 프로토콜을 인스턴스 실제형식으로 캐스팅)
====================================================================================**/


// 1) is연산자 ==============================

// 특정타입이 프로토콜을 채택하고 있는지 확인
tv is Remote
sbox is Remote


// 프로토콜 타입으로 저장된 인스턴스가 더 구체적인 타입인지 확인 가능
electronic[0] is TV // 즉 프로토콜 배열로 저장한 원소가 이 구체적 본래에 타입이냐 물어보는것
electronic[1] is SetTopBox




// 2) as연산자 ==============================

// 업캐스팅(as)
let newBox = sbox as Remote
newBox.turnOn()
newBox.turnOff()
// 프로토콜 타입으로 업캐스팅 해서 프로토콜에서 정의함 메서드 사용 가능


// 다운캐스팅(as?/as!)
let sbox2: SetTopBox? = electronic[1] as? SetTopBox
sbox2?.doNetflix()

//(electronic[1] as? SetTopBox)?.doNetflix()







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
