import UIKit


/*:
 ## 열거형의 원시값과 연관값
 * 열거형의 원시값(Raw Values)
 ---
 */
//:> 열거형의 원시값은 매칭되는 기본값(정수/문자열)을 정해, 열거형을 좀 더 쉽게 활용 가능

// 여러가지 형태로 원시값을 정의 가능 (Hashable한 - Int / String / Character / Double 등 가능)

// 일반적으로는 Int, String 주로 사용함
enum Alignment: Int {
    case left
    case center
    case right
}



// 원시값 입력안하면 0, 1, 2  이렇게 자동으로 저장됨 (정수의 경우 숫자가 하나씩 증가)
// 1(설정시), 2, 3
// 0, 2(설정시), 3     : 2 다음부터는 자동 1 증가한 값 하지만 이렇게 쓰는 경우는 드뭄



enum Alignment1: String {
    case left = "L"  // "L" 이렇게 따로 지정 안한다면 리터럴 값 이름  그대로 "left"로 정의 됨
    case center = "C"
    case right = "R"
}




// let align = Alignment.left  : 이코드와 아래 코드는 완전 동일 한것임
let align = Alignment(rawValue: 0)    // 인스턴스 생성시 - 옵셔널타입으로 리턴 (실패가능)
//let align1 = Alignment(rawValue:1) // 이런식으로 숫자와 매칭시켜 편하게 사용할 수 있는 개념이 원시값임

let leftValue = Alignment.center.rawValue     // 접근연산자를 통해 원시값 자체에도 접근가능
// let leftValue : Int = Alignment.center.rawValue     // 접근연산자를 통해 원시값 자체에도 접근가능


Alignment1(rawValue: "C")             // (가능하지만) 문자열 방식으로는 잘 사용하지는 않음
let centerValue = Alignment1.center.rawValue



/*:
 ---
 * 원시값(Raw Values)의 활용
 ---
 */
//:> 숫자 또는 문자열과 매칭시켜 자유롭게 활용 가능 (숫자 ←→ 열거형 타입)

// 가위 바위 보 열거형 만들기

enum RpsGame: Int {
    case rock
    case paper
    case scissors
}




// 실제 앱을 만들때는

// 사실 RpsGame.rock 와 RpsGame(rawValue: 0)는 좀 다름 RpsGame(rawValue: 5)를 입력했을때 nil이 반환됨
// var test = RpsGame(rawValue: 0)  test 변수 확인시 옵셔널 변수로 나오는 것을 확인 할 수 있음

RpsGame(rawValue: 0)!
RpsGame(rawValue: 1)
RpsGame(rawValue: 2)



// 논리적으로 nil이 될 수 없다면

let number = Int.random(in: 0...100) % 3    // 3을 조금 더 멋지게 처리할 수 있는 것은 고급내용에서 다룸

print(RpsGame(rawValue: number)!)      // 출력은 하지만 문자열은 아님에 주의
// RpsGame(rawValue: number) 자체가 열거형 타입이라고 생각하기 출력할때는 그냥 그 타입을 보여준다고 생각하면 됨



// 옵셔널값을 안전하게 벗겨서 사용

if let r = RpsGame(rawValue: 0) {
    print(r)                           // 출력은 하지만 문자열은 아님에 주의
}




// 행성 열거형 만들기

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
} // 이렇게 1만 해줘도 나머지 자동 숫자 증가 된 값을 가짐


let planet = Planet(rawValue: 2)!
// Planet.mercury




let num = planet.rawValue
print(num)






/*:
 ---
 * 열거형의 연관값(Associated Values)
 ---
 */
//:> 열거형의 연관값은 구체적인 추가정보를 저장하기 위해 사용
// 쉽게 카테고리라고 생가하면 편함 각 카테고리에 구체적인 값을 저장 할 수 있게 하려고 할때 사용할수 있겠군아
enum Computer {
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}



// 각 케이스별로 상이한 특징이 있고, 그것을 저장 / 활용할 필요가 있을 때

// 개별케이스마다 저장할 형식을 따로 정의(자료형에 제한이 없음 / 튜플의 형태)
// 하나의 케이스에 서로다른 연관값을 저장할 수 있음 ===> 선언시점이 아니라, 새로운 열거형 값을 생성할때 저장



let myChip1 = Computer.cpu(core: 8, ghz: 3.5)
let myChip2 = Computer.cpu(core: 4, ghz: 2.0)

let myChip3 = Computer.ram(16, "DRAM")
let myChip4 = Computer.ram(4, "SRAM")
let myChip5 = Computer.ram(32, "DRAM")

let myChip6 = Computer.hardDisk(gb: 128)
let myChip7 = Computer.hardDisk(gb: 512)






// 원시값을 활용한다면 ====> 불가능

enum Computer1: String {
    case cpu = "6coreX2.6ghz"
    case ram = "32GBXDDR4"
    case hardDisk = "256gb"
}

// 모든 케이스들을 다 만들수가 없음



/*:
 ---
 * 원시값(Raw Values)과 연관값(Associated Values)의 차이
 ---
 */
/**=============================================================================
 - 1) 자료형 선언 방식: 선언하는 위치가 다름
 - 2) 선언 형식: (1) 원시값 ===> 2가지중 1가지 선택 / (2)연관값 ===> 튜플의 형태로 형식 제한 없음
 - 3) 값의 저장 시점: (원시값: 선언시점 / 연관값: 새로운 열거형 값을 생성할때 )
 - 4) 서로 배타적: 하나의 열거형에서 원시값과 연관값을 함께 사용하는 것은 불가능 함
=================================================================================**/


/*:
 ---
 * 연관값(Associated Values)의 활용
 ---
 */

var chip = Computer.cpu(core: 8, ghz: 2.0)
//chip = Computer.ram(32, "DRAM")

switch chip {
case .cpu(core: 8, ghz: 3.1):
    print("CPU 8코어 3.1GHz입니다.")
case .cpu(core: 8, ghz: 2.6):
    print("CPU 8코어 2.6GHz입니다.")
case .ram(32, _):
    print("32기가램 입니다.")  // 32만 맞아도 여기로 들어옴 뒤에 _ 생략한다고 했으니까
default:
    print("그 이외의 칩에는 관심이 없습니다.")
}



// 연관값을 가진 케이스를 패턴 매칭시키기

switch chip {
   //.cpu(let a, let b): 밖으로 꺼낸 형태가 아래와 같은 형태
case let .cpu(a, b):    // let a = 연관값, let b = 연관값 : 이렇게 바인딩 하여 사용가능함 a = 8, b = 2.0
    print("CPU \(a)코어 \(b)GHz입니다.")
case let .ram(a, _):
    print("램 \(a)기가램 입니다.")
case let .hardDisk(a) :
    print("하드디스크 \(a)기가 용량입니다.")
}







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
