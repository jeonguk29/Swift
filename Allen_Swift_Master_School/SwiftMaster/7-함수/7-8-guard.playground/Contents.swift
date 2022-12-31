import UIKit


/*:
 # guard문
 */
/*:
 ## 가드문(guard statement)
 * 불만족하는 조건을 사전에 걸러내는 조건문
 ---
 */
//:> if문의 단점 - 여러개의 조건이 있을때 코드의 가독성이 문제됨 ➞ guard문으로 단점 극복
// if문을 만족하는 경우, 지속적인 들여쓰기로 인해 코드의 가속성이 안 좋아질 수 있음
// (실제 프로젝트에서는 코드를 알아보기 힘듦)



/**=======================================================
 - guard문
 - 1) else문을 먼저 배치 - 먼저 조건을 판별하여 조기 종료(early exit)
 - 2) 조건을 만족하는 경우 코드가 다음 줄로 넘어가서 계속 실행
 - 3) 가드문에서 선언된 변수를 아래문장에서 사용 가능 (동일한 스코프로 취급) (guard let 바인딩 관련)
=======================================================**/

/*:
 ---
 * 가드문의 이해
 ---
 */

func checkNumbersOf1(password: String) -> Bool {
    
    if password.count >= 6 {
        
        // 로그인을 처리하는 코드 작성
        // 1
        // 2
        // 3
        // 4
        // 5
        
        return true
        
    } else {
        
        return false
        
    }

}

// if문은 조건에 맞으면 현제 조건을 확인중인 {} 안으로 들어가고 아니면 한참 내려가서 else문을 실행시킴
// guard문은 조건에 맞지않으면 else문먼저 실행시키는게 차이점임 조기 종료(early exit) 전략


func checkNumbersOf2(password: String) -> Bool {
    
    // 감시하다
    guard password.count >= 6 else {
        return false                          // 종료 조건 - 함수 내에서는 return / throw
    }//만족하면 아래 코드로 내려갈건데 아니면 false를 반환 처리하고 끝내버리겠다는 것임
    // 쉽게 if-else문에서 else가 먼저 실행되는게 guard문이라고 생각하자
    // if문 처럼 코드가 계속 안으로 들어가지 않음
    
    // 로그인을 처리하는 코드 작성
    // 1
    // 2
    // 3
    // 4
    // 5
    
    return true
}





/*:
 ---
 * 가드문의 사용 예시
 ---
 */


// 반드시 코드를 종료해야하는 조기 종료의 조건이 필요하므로, 로컬스코프(함수/반복문) 내에서만 사용 가능

func check(words: String) -> Bool {
    
    guard words.count >= 5 else {
        
        print("5글자 미만입니다.")
        
        return false                             // 종료 조건 - 함수 내에서는 return / throw
        // 함수를 종료시키는 return 키워드 필수임
    }
    
    print("\(words.count)글자입니다.")
    
    return true
}



check(words: "안녕하세요")


//:> 실제 프로젝트에서 몇번 사용하다보면 바로 감이 옴






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
