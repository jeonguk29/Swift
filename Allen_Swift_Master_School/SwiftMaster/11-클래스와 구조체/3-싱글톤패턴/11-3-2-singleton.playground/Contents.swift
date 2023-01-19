import UIKit

/*:
 # Part11 - 3 싱글톤(Singleton)
 */
/*:
 ## 싱글톤(Singleton) 패턴
 * 싱글톤 패턴이 필요한 이유
 ---
 */
/**=======================================================
 - 앱 구현시에, 유일하게 한개만 존재하는 객체가 필요한 경우에 사용
 - (특정한 유일한 데이터/관리 객체가 필요한 경우)

 - 한번 생성된 이후에는 앱이 종료될때까지, 유일한 객체로 메모리에 상주
=======================================================**/

/*:
 ---
 * 싱글톤 패턴의 문법적 이해
 ---
 */

class Singleton {
    // 타입 프로퍼티(전역변수)로 선언
    static let shared = Singleton()      // 자신의 객체를 생성해서 전역변수에 할당
    var userInfoId = 12345
    private init() {}
}


//:> 변수로 접근하는 순간 lazy하게 동작하여, 메모리(데이터 영역)에 올라감

Singleton.shared    // 스택영역에 올라가는게 아님 클래스 안에 자기자신의 인스턴스 주소를 담는 shared를 데이터영역에 담는것임
// 그 생성된 인스턴스가 종료 될때 까지 보관함
// 아래와 같이 유알한 존재의 객체라 공유가 가능함 한 군데를 바꾸면 전체가 바뀜 가리키는 곳은 하나이기 때문

let object = Singleton.shared
object.userInfoId = 1234567

Singleton.shared.userInfoId


let object2 = Singleton.shared    // 유일한 객체를 가르키는 것일뿐
object2.userInfoId


Singleton.shared.userInfoId




// 그렇지만 아래와 같은 것도 가능 ===> 새로운 객체를 생성한 것임

//let object3 = Singleton() : 근데 싱글톤 패턴자체가 유일하게 존재하기 위해 만드는거라 이렇게 새로운 객체를 못 찍어내게 만들 수 있음
//object3.userInfoId



// private init() 설정으로 새로운 객체 추가적 생성이 불가하게 막는 것 가능

// 일반적으로 private init()까지 해주는게 올바른 싱글톤 패턴 구현 방법임


/*:
 ---
 * 실제 사용 예시
 ---
 */
// 앱을 실행하는 동안, 하나의 유일한 객체만 생성되어서, 해당 부분을 관리          :          애플이 미리 만들어 놓은 수많은 경우에 사용함

let screen = UIScreen.main    // 화면
let userDefaults = UserDefaults.standard    // 한번생성된 후, 계속 메모리에 남음!!!
let application = UIApplication.shared   // 앱
let fileManager = FileManager.default    // 파일
let notification = NotificationCenter.default   // 노티피케이션(특정 상황, 시점을 알려줌)


// 이게 다 타입 속성 처럼 접근해서 사용하는 싱글톤 패턴임 





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
