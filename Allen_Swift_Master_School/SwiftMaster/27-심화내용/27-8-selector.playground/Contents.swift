import UIKit

/*:
 ## 셀렉터(selector)
 * #selector의 사용 예시
 ---
 */

class ViewController: UIViewController {
    
    lazy var myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("MyButton", for: .normal)
        button.frame = CGRect(x: 0.0, y: self.view.frame.height - 150, width: view.frame.width, height: 50.0)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myButton)
        myButton.addTarget(self, action: #selector(ViewController.doSomething(_:)), for: .touchUpInside)

        // 셀렉터의 사용⭐️
        //myButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
    }
    
    // 셀렉터는 오브젝티브C에서 인식할 수 있는 속성/메서드만 가르킬 수 있음
    @objc func doSomething(_ sender: Any) {

    }
    
}


//let someSelector = <#T##Selector#>




/*:
 ---
 * #selector의 개념에 대한 이해
 ---
 */
// 클래스, Objective-C 프로토콜에 포함된 멤버에만 적용가능(구조체 적용 불가)
// 내부적으로 Objective-C 프레임워크를 사용하고 있기 때문에
// @objc 특성을 추가해야지만 사용가능

/*
 😀 메서드의 주소를 통해서 해당 메서드를 가르키겠다는 것임
 */

class Dog {
    var num = 1.0
    
    @objc var doubleNum: Double {
        get {
            return num * 2.0        // 계산 속성은 실질적 메서드
        }
        set {
            num = newValue / 2.0
        }
    }
    
    @objc func run() {
        print("강아지가 달립니다.")
    }
}


//let selector = <#T##Selector#>

// 문법적인 약속
// (계산)속성을 가르킬때
let eyesSelector = #selector(getter: Dog.doubleNum)    // 계산(읽기) 속성
let nameSelector = #selector(setter: Dog.doubleNum)    // 계산(쓰기) 속성
// 😀 계산속성을 가리킬때는 getter, setter 메서드인지 알려줘야함

// 메서드를 가르킬때
let runSelector = #selector(Dog.run)

/*
 😀 #selector(Dog.run) 우리가 가르키코 싶은 메서드를 넣으면 90 이렇게 메모리 주소가 생기는 것임
 클로저와 비슷하게 주소를 담지만
 runSelector() 이렇게 실행을 할 수는 없는 것임
 단순하게 메서드를 가리키는 것임
 
 실질적으로 이렇게 변수에 담아 쓰는경우는 없고 Selector2 폴더에 앱만들때 어떻게 사용하는지 보기
 
 */


//:> 셀렉터는 속성에 접근이나 메서드를 호출하는 것이 아님 ➞ 가르키기만 할뿐
// 코드 영역의 메모리 주소를 가리켜서, (버튼이 눌렸을 때 해당 메서드를 실행시키기 위해) 연결시키는 기술







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
