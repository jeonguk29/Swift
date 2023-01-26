import UIKit


/*:
 ## 5) 프로토콜의 확장(Protocol Extension)
 * 프로토콜의 확장 - 프로토콜 지향 프로그래밍 ⭐️
 ---
 */

protocol Remote {
    func turnOn()
    func turnOff()
}


// 채택 ===> 실제구현해야함(여러타입에서 채택한다면 반복적으로 구현해야하는 점이 불편)

class TV1: Remote {
    func turnOn() { print("TV 켜기") }
    //func turnOff() { print("리모콘 끄기") }
    
    func doAnotherAction() {
        print("TV 또 다른 동작")
    }
}


// 채택 ===> 실제구현해야함(여러타입에서 채택한다면 반복적으로 구현해야하는 점이 불편)

struct Aircon1: Remote {
    //func turnOn() { print("리모콘 켜기") }
    //func turnOff() { print("리모콘 끄기") }
}




//:>프로토콜의 확장 ➞ 기본(디폴트) 구현 제공 ⭐️
/**==============================================================================
 - (귀찮은 방식으로) 프로토콜을 채택한 모든 타입에서, 실제 구현을 계속적으로 반복해야하는 불편함을 덜기 위해
 - "프로토콜 확장"을 제공해서 메서드의 디폴트 구현을 제공함 (코드의 중복을 피할 수 있음)
===============================================================================**/


extension Remote {                         // (요구사항의 메서드 우선순위 적용 - 프로토콜 메서드 테이블 만듦)
    func turnOn() { print("리모콘 켜기") }    // 1. (채택)구현시 해당 메서드 2. 기본 메서드
    func turnOff() { print("리모콘 끄기") }   // 1. (채택)구현시 해당 메서드 2. 기본 메서드
    
    //컴파일러가 번역해서 테이블 생성 하지 않고 이코드가 위치한 주소를 그냥 줘버림 ex 300번째
    func doAnotherAction() {               // (요구사항 메서드 X - 테이블 만들지 않음)
        print("리모콘 또 다른 동작")            // 타입에 따른 선택 (Direct Dispatch)
    }
}
// 이렇게 프로토콜을 확장에서 재대로 구현하면 반복적으로 구현해야하는 경우를 막을수 있음

var tv7 = TV1()
tv7.turnOn()        //  직접 클래스 채택하여 구현한게 우선순위라 이렇게 나옴
tv7.turnOff()
tv7.doAnotherAction()


var tv8: Remote = TV1()
tv8.turnOn()
tv8.turnOff()
tv8.doAnotherAction() // 프로토콜 타입으로 만들어서 프로토콜 타입에 해당 하는 "리모콘 또 다른 동작" 출력됨
/*
 정리 프로토콜에서 정의한 요구사항의 따른 메서드를 확장에서 채택하여 구현시 우선순위는 클래스 내에서 직접 채택한게 1순위
 그게 없다면 확장에서 정의한게 2순위
 
 프로토콜에서 정의하지 않은 즉 요구하지 않은 사항의 메서드를 확장하여 구현했을때, 클래스에 직접 채택하지 않았다면 기본 구현 되고
 만약 클래스에도 직접 구현 했다면 타입에 따라 다름 Remote 타입으로 인스턴스 생성시 Remote에 맞는 즉 확장에서 정의한게 출력되고
 클래스에 맞는 인스턴스 구현시 클래서 구현된게 보임
 */

/*:
 ---
 * 프로토콜의 확장을 통한 다형성 제공 - 프로토콜 지향 프로그래밍
 ---
 */
// 클래스 ⭐️ ==================================================

class Ipad: Remote {
    func turnOn() { print("아이패드 켜기") }

    func doAnotherAction() { print("아이패드 다른 동작") }
}


/**=================================================
 [Class Virtual 테이블]
 - func turnOn()          { print("아이패드 켜기") }
 - func turnOff()         { print("리모콘 끄기") }                       // 구현 안해서 프로토콜 확장에서 제공한걸 사용함
 - func doAnotherAction() { print("아이패드 다른 동작") }
====================================================**/


let ipad: Ipad = Ipad()
ipad.turnOn()           // 클래스 - V테이블
ipad.turnOff()          // 클래스 - V테이블
ipad.doAnotherAction()  // 클래스 - V테이블

// 아이패드 켜기
// 리모콘 끄기
// 아이패드 다른 동작



/**=====================================
 [Protocol Witness 테이블] - 요구사항
 - func turnOn()  { print("아이패드 켜기") }
 - func turnOff() { print("리모콘 끄기") }
========================================**/


let ipad2: Remote = Ipad()
ipad2.turnOn()           // 프로토콜 - W테이블
ipad2.turnOff()          // 프로토콜 - W테이블
ipad2.doAnotherAction()  // 프로토콜 - Direct (직접 메서드 주소 삽입)
//ex 300번째 주소로 가라 테이블을 거치지 않고 바로 주소로 때려버림 이코드를 만날때 그렇게 하라고 컴파일러가 지정
/*
 클래스에 정의 되어있다면 버츄얼 테이블로 들어가서 찾아서 다시 이동하여 동작하지만
 그냥 단순 프로토콜 확장에 구현했다면 코드가 위치한 주소로 다이렉트로 바로 접근해버림
 */
// 아이패드 켜기
// 리모콘 끄기
// 리모콘 또 다른 동작





// 구조체 ⭐️ ==================================================

struct SmartPhone: Remote {
    func turnOn() { print("스마트폰 켜기") }

    func doAnotherAction() { print("스마트폰 다른 동작") }
}


/**=====================================
 [구조체] - 메서드 테이블이 없음
========================================**/


// 본래의 타입으로 인식했을때
var iphone: SmartPhone = SmartPhone()
iphone.turnOn()             // 구조체 - Direct (직접 메서드 주소 삽입)
iphone.turnOff()            // 구조체 - Direct (직접 메서드 주소 삽입)
iphone.doAnotherAction()    // 구조체 - Direct (직접 메서드 주소 삽입)

// 500
// 501
// 400 이런식으로 그냥 메모리 주소를 심어버림

// 스마트폰 켜기
// 리모콘 끄기
// 스마트폰 다른 동작



/**=====================================
 [Protocol Witness 테이블] - 요구사항
 - func turnOn()  { print("스마트폰 켜기") }
 - func turnOff() { print("리모콘 끄기") }
========================================**/


// 프로토콜의 타입으로 인식했을때
var iphone2: Remote = SmartPhone()
iphone2.turnOn()            // 프로토콜 - W테이블
iphone2.turnOff()           // 프로토콜 - W테이블
iphone2.doAnotherAction()   // 프로토콜 - Direct (직접 메서드 주소 삽입)

// 스마트폰 켜기
// 리모콘 끄기
// 리모콘 또 다른 동작



/*
 프로토콜을 채택시
채택한 타입마다 각각 따로 witness table을 만듭니다. 왜냐하면.. 해당 프로토콜을 채택해서, 실제 구현을 하면, 구현 내용에 따라 실행해야할 메서드가 바뀌기 때문에, (해당 코드영역의 메서드 주소를 담아놓으려면) 테이블이 따로 따로 존재해야합니다.
 
 Remote라는 이름으로 공통된 테이블로 만들어지는 것은 아님
 
 정리: 타입에서 채택시 각각의 따로 witness table을 만듬 그런다음 클래스에서 채택하여 구현한다면 그 채택하여 구현한 곳에 저장주소를 여기다 담음
 일반적으로 모두 구현해야하니 클래스에서 채택하여 구현한 코드들의 위치에 해당하는 주소가 각각 위치하게 될거고
 만약 하나는 클래스에서 구현 하고 하나를 프로토콜 확장으로 구현한다면 하나는 클래스에서 구체적 정의한 코드의 주소, 하나는 확장에서 구체적으로 정의한 위치에 주소가 이안으로 들어갈것임 비어 있을수는 없음 컴파일시 모두 구현해야하는 법칙이 있기 때문에
 
 프로토콜에서 정의한 요구사항의 따른 메서드를 확장에서 채택하여 구현시 우선순위는 클래스 내에서 직접 채택한게 1순위
 그게 없다면 확장에서 정의한게 2순위 이것이 컴파일일될때 다 정리 될것임
 
 프로토콜에서 정의하지 않은 즉 요구하지 않은 사항의 메서드를 확장하여 구현했을때, 클래스에 직접 구현했다면 가상 테이블에 그냥 위치하는거고
 (근본적으로) 만약 채택하지 않았다면 witness table에 만들지 않고 컴파일시 그냥 그 코드 주소 자체를 삽입해버림

 그리고 같은 이름으로 확장에서도 클래스에서도 구현했다면  Remote 타입으로 인스턴스 생성시 Remote에 맞는 즉 확장에서 정의한게 출력되고
 클래스에 맞는 인스턴스 구현시 클래서 구현된게 보임 + 프로토콜에서 요구한게 아니라면 확장한 코드 그자체적인 주소 값으로 찍어 버리고
 모두 다 컴파일시 적용됨 
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
