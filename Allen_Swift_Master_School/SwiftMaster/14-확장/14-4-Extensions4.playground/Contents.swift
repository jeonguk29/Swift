import UIKit

/*:
## 3) 멤버의 확장(생성자)
 * 3. 생성자의 확장
 ---
 */
//:> 클래스 - 편의 생성자만 구현 가능 / 구조체(값타입) - 지정생성자 형태로도 (자유롭게) 생성자 구현 가능
/**=========================================================================
  [클래스]
 - 편의 생성자만 추가 가능 (즉, 본체의 지정생성자를 호출하는 방법으로만 구현 가능) ⭐️
 - 지정생성자 추가 불가 / 소멸자 추가 불가 (항상 본래의 클래스에서 정의해야 함)

 
  [구조체]
 - 구조체는 (원래) 편의 생성자가 존재하지 않고, 상속과 관련이 없기 때문에
   지정생성자의 형태로도 (자유롭게) 생성자 구현 가능 ⭐️
   (1) (편의 생성자와 비슷한) 생성자를 추가하여 본체의 지정 생성자를 호출하는 방법으로도 구현 가능하고
   (2) 새롭게 지정생성자 형태로 구현하는 것도 가능
 
  [구조체 참고 사항]
 - (본체) 직접 생성자 구현하면, 기본 생성자 init() /멤버와이즈 생성자 제공 안되는 것이 원칙
 
 - (예외) (본체) 모든 저장속성에 기본값제공 + (본체에 직접) 생성자를 구현하지 않았다면, 확장에서는 괜찮음
 - (즉, 확장에서 생성자를 구현해도, 본체에는 여전히 기본 생성자/멤버와이즈 생성자가 자동 제공
    되고 본체의 기본 생성자/멤버와이즈 생성자 호출하는 방식으로의 구현도 가능)
=========================================================================**/



/*:
---
* 구조체 - 생성자 확장의 예시
---
*/
// 포인트 구조체, 사이즈 구조체

struct Point {
    var x = 0.0, y = 0.0
    
//    init(){ // 이게 클래스 였다면 convenience init() 이렇게 키워드를 붙였을 것임 하지만 구조체는 원해부터 편의 생성자가 존재 X
//        self.init(x:0.0, y:0.0)
//    }
    
 
    /*
     init(x: Double, y: Double) {
         self.x = x
         self.y = y
     }
     
     구조체 같은 경우  init(),     init(x: Double, y: Double) 생성자 구현 안하면 자동으로 이렇게 2개 구현 됨
     멤버와이즈, 기본 생성자 제공을 해줌
     */
    
}

extension Point {
//    init() { // 오류
//       self.init(x:0.0, y:0.0)
//    }
    
    init(num: Double) { // 그래서 확장시 위에 2개 와 같은 형태면 오류남 왜 똑같은 걸 또 확장하니?
        self.init(x:0.0, y:0.0) // 어찌 됬던 중요한건 구조체도 확장시 본래에 지정 생성자를 불러야함
    }
}


// 예외인 경우 아래와 같이 초기값이 있을때 확장시 지정생성자 호출이아니라 구현 가능
struct Point2 {
    var x = 0.0, y = 0.0
    //    init()
    //    init(x: Double, y: Double)
    
}

extension Point2 {

    init(num: Double) {
        self.x = num
        self.y = num

    }
}



struct Size {
    var width = 0.0, height = 0.0
}



// Rect구조체

struct Rect {     // 기본값 제공/생성자 구현안함  ===> 기본 생성자 / 멤버와이즈 생성자가 자동 제공 중
    var origin = Point()
    var size = Size()
}



let defaultRect = Rect()    // 기본생성자

// 다 구조체라 각각 멤버와이즈 이니셜 라이즈가 기본으로 있음
//Rect(origin: Point(x: <#T##Double#>, y: <#T##Double#>), size: Size(width: <#T##Double#>, height: <#T##Double#>))

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))    // 멤버와이즈 생성자



extension Rect {
    // 센터값으로 Rect 생성하는 생성자 만들기
    // 예외적인 경우 (저장속성에 기본값 + 본체에 생성자 구현 안한 경우, 여전히 기본생성자/멤버와이즈 생성자 제공)
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        // (1) 본체의 멤버와이즈 생성자 호출 방식으로 구현 가능
        self.init(origin: Point(x: originX, y: originY), size: size)
        
        // (2) 직접 값을 설정하는 방식으로도 구현 가능
        //self.origin = Point(x: originX, y: originY)
        //self.size = size
    }
}


// 새로 추가한 생성자로 인스턴스 생성해보기

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))




/*:
---
* 클래스 - 생성자 확장의 예시
---
*/
// UIColor 기본 생성자
var color = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1)
    


extension UIColor {      // 익스텐션 + 편의생성자 조합
    
    convenience init(color: CGFloat) {   // Float   / Double
        self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)
    }

}
// CGFloat은 애플이 미리 만들어 놓은 UIkit 프래임 워크 안에서 CG는 core graphic 약자임 애플이 뭔가 색상을 사용할때
// Float을 가지고 미리 구현해놓은 타임임
/*
 클래스던 구조체던 편의 생성자를 확장 가능하며 편의 생성자 확장시 규칙인 지정 생성자를 불러야함
 구조체는 convenience 즉 편의 생성자라는 개념이 없지만
 */

// 일단 아주 쉽게 객체 생성하는 방법을 제공 가능해짐

UIColor(color: 1)
//UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)








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
