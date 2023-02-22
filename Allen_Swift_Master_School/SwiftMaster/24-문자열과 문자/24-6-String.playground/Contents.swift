import UIKit

/*:
 ## 문자열을 배열로 변환
 * 문자열의 배열화, (문자열)배열의 문자열화
 ---
 */
//:> 문자열(데이터바구니) ⇄ 배열  (쉽게 변형가능)
/**============================================
 - 문자열 자체도, 여러개의 문자를 담고 있는 데이터이기 때문에
   쉽게 배열로 변형이 가능하고, 반대 변형도 쉬움
 
 -  String    <====>  [String]   문자열 배열
 -  String    <====> [Character] 문자 배열
 ============================================**/


var someString = "Swift"


// 1) 문자열을 문자열(String) 배열화 하기 ⭐️

//

var array: [String] = someString.map { String($0) } // 문자열에도 map이라는 고차함수가 구현 되어있는것임
print(array)


// 2) 문자열을 문자(Character) 배열화 하기

var array2: [Character] = Array(someString)     // [Character]      //typealias Element = Character
// 그냥 배열 생성자를 통해서 넘겨주면 문자형으로 저장됨 근데 이렇게 문자로는 사용 잘안함 위에 것을 기억하자


// (참고) 문자열을 문자열(String) 배열화하는 추가적 방법
var array3: [String] = Array(arrayLiteral: someString)  // [String]

// 실무에서는 1번 가장 많이 사용함



// 3) 문자열 배열 [String] =====> 문자열

var newString = array.joined()  // 쪼개져있는 문자열 배열을 하나로 합쳐줌
newString = array3.joined()


// 4) 문자 배열  [Character] ======> 문자열

var newString2 = String(array2)
/*
 케릭터 문자배열은 joined 메서드가 구현 되어있찌 않음 그래서 문자열로 만들때는 그냥 문자열 생성자 안에 넣어주면
 하나의 문자로 합쳐서 넣어줌
 */


// 가장 중요한건 분리시켜주는 map 고차함수와 합쳐주는 joined 메서드 기억하자

/*:
 ---
 * (활용 예시) 문자열을 뒤죽박죽 섞는다면?
 ---
 */
someString = "Swift"


someString.randomElement()     // 문자열에서 랜덤으로 뽑아내는 것 가능
someString.shuffled()          // 섞어서 문자(Character) 배열로 리턴 ["t", "i", "w", "S", "f"]




//someString.shuffled().joined()     // 불가능 (문자배열 이기때문)


var newString3 = String(someString.shuffled())  // 섞인 문자배열을 문자열로 만듬
print(newString3)


// map고차함수를 사용해서 변환 ⭐️

newString3 = someString.map { String($0) }.shuffled().joined()
print(newString3)
// 배열의 순서를 뒤죽 박죽 섞는 shuffled 메서드를 사용하고 joined 로 문자열을 합쳐주면 됨

/*
 나중에 코딩테스트 알고리즘 문제 풀때 문자열을 어떻게 뒤죽박죽 섞을수 있을까? 라고 할때 바로
 아 문자열을 배열로 만들어서 섞은다음 다시 문장열로 합치면 되겠군아 떠올릴 수 있어야함
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
