import UIKit

/*:
 ## 정규식 / 정규표현식
 * 정규식(정규표현식)을 이용한 문자열의 판별
 ---
 */
//:> 정규식(正規式)은 "특정한 규칙"을 가진 문자열의 집합을 표현하는 데 사용하는 형식 언어
// (스위프트에만 해당하는 것이 아님)


// 올바른 전화번호 형식일까?
// (정규식 확인하는 코드)

let number = "010-1234-12345"


// 정규식 (RawString으로 작성하면 메타문자를 바로 입력가능) ===> 가독성 높아짐
// (스위프트에서는 \ 백슬레시를 이스케이프 문자로 인식하기 때문)

var telephoneNumRegex = #"[0-9]{3}\-[0-9]{4}\-[0-9]{4}"#
/*
 [0-9] : 0부터 9까지 숫자를 사용할 수 있으며
 {3}   : 3자리 사용이 가능하다
 \-    : 중간에 -이게 필요하다
 
 외우는게 아님 이런식으로 어떤 틀을 정의하는 것임 이게 정규식이라는 타입이고 우리가 사용한 문자열이랑 비교하여
 이런 타입으로 쓰였는지 비교하는 것임
 */

// 반드시 문자열 옵션을 정규식이라고 알려줘야함 regularExpression
// 해당 문자열의 범위를 우리가 만든 범위의 틀과 비교해줌 아래와 같이 range로 사용함
if let _ = number.range(of: telephoneNumRegex, options: [.regularExpression]) {
    print("유효한 전화번호로 판단")
}


//:> 간단한 정규식 사용
// 정규식에 대한 내용을 찾으려면, 구글 및 유튜브 검색 및 활용

/**=========================================================**/
  #"[0-9]{3}[- .]?[0-9]{4}[- .]?[0-9]{4}"#   // 전화번호 러프하게
  #".*@.*\..*"#                              // 이메일 러프하게
  #"[0-9]{3}\-[0-9]{3}"#                     // 우편번호 러프하게
/**=========================================================**/
// [- .] - 공백 , 사용이 가능하고 ? 없을 수도 있다는 뜻 외우지마 찾아 쓰자


// 참고
// https://www.youtube.com/watch?v=Gg0tlbrxJSc
// https://www.youtube.com/watch?v=-5cnj7q1-YY
// https://regexr.com/
// https://regexr.com/5nvc2







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
