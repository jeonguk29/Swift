import UIKit

/*:
 ## CaseIterable 프로토콜
 * Enum타입에서 사용할 수 있는 CaseIterable (Swift 5.2 ~ )
 ---
 */
// Iterable: 영어의 뜻 ==> 반복가능한
/**=================================================================
 - 열거형에서 CaseIterable 프로토콜을 채택하면 타입 계산 속성이 자동으로 구현됨
 - static var allCases: Self.AllCases { get }

 - 이 "타입 계산속성"을 컴파일러가 자동으로 구현 제공 ====> 모든 케이스를 (정의한 순서대로) 포함한 배열을 리턴
 - 연관값(associated value)이 없는 경우에만 채택 가능 (원시값은 상관없음)
=====================================================================**/

// 연관 값이 있는 경우 그것을 어떤 순서로 나열할지에 대한 방법이 없음


enum Color: Int, CaseIterable {  // Int
    case red, green, blue
}



//var color = Color.red     // 열거형은 구조체, 클래스와 다르게 ()가 아닌 Color.red  자체가 인스턴스를 찍어내는거라고 했음
//color = .blue             // 이것도 따져보면 새로운 인스턴스를 찍어서 다시 넣는 것임
//color = .green



Color.allCases     // [Color.red, Color.green, Color.blue]
print(Color.allCases)

/*
 😀 열거형에서 CaseIterable 프로토콜을 채택하면 allCases 라는 타입속성을 사용 할 수 있음
 allCases 타입속성을 사용하면 모든 속성들을 배열값에 담아서 리턴해줌
 */


var color2 = Color(rawValue: 0)
color2 = Color(rawValue: Int.random(in: 0...Color.allCases.count))
// 😅 Color.allCases는 모든 원소를 배열로 리턴해주니까 .count를 붙여서 원소의 개수를 알아내어 범위를 지정 할 수도 있음
/*:
 ---
 * 배열의 장점을 사용해 여러가지 편의적 기능 활용 가능
 ---
 */
// 손쉽게 반복문 사용 가능
for color in Color.allCases {
    print("\(color)")   // 열거형의 아이템을 하나하나 뽑을 수도 있게됨
}


// 필요로 하는 곳에서 선언도 간단하게
struct SomeView {
    //let colors: [Color] = [Color.red, Color.green, Color.blue]
    let colors = Color.allCases // 위코드에 경우 case 추가시 일일히 다 입력헤줘야함.... ㅠㅠ
}



// 공식문서의 예제

enum CompassDirection: CaseIterable {
    case north, south, east, west
}

// 1) 케이스의 갯수를 세기 편해짐 (케이스를 늘려도 코드 고칠 필요 없음)
print("방향은 \(CompassDirection.allCases.count)가지")


// 2) 배열 ===> 고차함수 이용 가능

let caseList = CompassDirection.allCases
                               .map({ "\($0)" })    // 하나하나 문자열로 원소로 변환 : ["north", "south", "east", "west"]
                               .joined(separator: ", ")  // 배열 ===> 문자열화
// "north, south, east, west"

print(caseList) // 하나의 문자열로 출력 됨

// 랜덤 케이스를 뽑아낼 수 있음

let randomValue = CompassDirection.allCases.randomElement()



// 😀 즉 배열로 리턴하기 때문에 배열에서 사용할 수 있었던 메서드들을 다 사용가능함


/*:
 ---
 * 열거형 단원에서 다뤘던 원시값(Raw Value)를 이용한 케이스
 ---
 */
// 가위바위보 케이스

enum RpsGame: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2
}


let number = Int.random(in: 0...100) % 3    // 3을 조금 더 멋지게 처리할 수 있는 것은 고급내용에서 다룸

let number2 = Int.random(in: 0...100) % RpsGame.allCases.count    // 나머지를 구하는 것이니 무조건 0, 1, 2 중에 한가지임
// 해당 코드로 구현시 개발자가 실수 할 경우를 대비할 수 있는 것임  %3 , %4 신경 x

print(RpsGame.init(rawValue: number)!)



RpsGame.allCases.randomElement()    // 사실 위에코드도 필요없음 그냥 이렇게만 해주면 끝남




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
