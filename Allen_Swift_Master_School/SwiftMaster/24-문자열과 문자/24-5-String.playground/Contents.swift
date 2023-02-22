import UIKit

/*:
 ## Substring
 * 서브 스트링(Substring)의 개념
 ---
 */

var greeting = "Hello, world!"
/*
 let index: String.Index 아래 변수 타입은 이렇게 되어 있음
 배열에서도 [0,1,2,3] 인덱스 개념이 있었는데 이때 인덱스는 인트형이였음
 문자열에서 인덱스는 조금 다른 개념임
 */
//           찾으려는 문자열이 없을 수도 있으니(nil 나올것임) 닐코어래싱을 통하여 ?? 기본적으로 마지막 인덱스를 넣겠다는 말임
let index: String.Index = greeting.firstIndex(of: ",") ?? greeting.endIndex    // ,(콤마)의 인덱스
let beginning: String.SubSequence = greeting[..<index]// 처음부터 인덱스까지
// beginning에는 위에서 자른 , 전까지의 문자열이 있을 것임 근데 타입 확인시 그냥 문자열이 아님

// "Hello"   // 타입 확인해보기 ⭐️  String.SubSequence 타입

/*
 서브 스트링(Substring) 개념은 문자열을 위 코드처럼 뽑아냈더니 새로운 메모리 공간을 만드는게 아니고
 기존 "Hello, world!" 공간에서 앞에 있는 부분만 사용하겠다 라는 개념임
 즉 메모리 공간을 공유하는 개념이라고 생각하자
 */

/**======================================================
 - prefix(...)메서드 등의 사용시
 - "Hello"란 beginning문자열은 greeting 문자열의 메모리공간을 공유
 - 스위프트 내부적으로 최적화되어 있음
 - 수정 등이 일어나기 전까지 메모리 공유
 - 오랜기간 저장하기 위해서는, 새롭게 문자열로 저장할 필요
 ========================================================**/


var word: String.SubSequence = greeting.prefix(5)   // prefix 앞에서 부터 글자를 자르겟다

word     // String.SubSequence 타입       이놈도 서브 스트링임
// "Hello"


greeting = "Happy"    // 원본을 바꾸는 순간 Substring 문자열들은 새로운 문자열 공간을 만들어서 저장

print(beginning)
print(word) // 이 두 서브 스트링 변수들은 이제 새로운 메모리 공간을 가지게 되는 것임



word = greeting.suffix(3)

word     // String.SubSequence 타입
// "ppy"




// 아니면 명시적으로 문자열로 변환해서 저장 가능 (서브스트링에서 벗어남)
let newString: String = String(word)









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
