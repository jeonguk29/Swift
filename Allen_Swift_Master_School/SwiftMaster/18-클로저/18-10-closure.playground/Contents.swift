import UIKit


/*:
 ## 캡처리스트 실제 사용 예시
 * Strong Reference(강한 참조)의 경우
 ---
 */
// 강한 참조가 일어나고, (서로가 서로를 가르키는) 강한 참조 사이클은 일어나지 않지만
// 생각해볼 부분이 있음


class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)        // 잠깐 CPU 3초 동안 동작 멈춤
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}                              // 이 함수는 이미 종료 ==> vc변수 없음


//localScopeFunction()

// (3초후)
// 글로벌큐에서 출력하기: 뷰컨
// 뷰컨 메모리 해제

/*
 1. localScopeFunction 함수 실행시 vc 변수에 ViewController() 인스턴스 하나 생성 vc 인스턴스는 Reference Counting 1
 2. vc.doSomething() 과 동시에 클로저를 힙에 생성 (2번째 CPU가 사용하기 위해 공용 영역 힙에 저장) 클로저가 vc 인스턴스를 캡처해서
 vc 인스턴스는 Reference Counting 2, 해당 클로저를 객체내에서 가리키고 있는 것은 없음
 
 3. localScopeFunction 함수 종료 되면서 vc 변수 사라지고 vc 인스턴스는 Reference Counting 1
 4. 두번째 cpu 스택에서 해당 클로저를 사용하여(-> vc인스턴스를 이용) 작업이 끝나면 클로저가 종료 되면서 스택에서 사라졌기 때문에
 이 클로저가 존재할 필요가 없는 것임 그래서 해당 힙영역에서 클로저가 사라지게 되는 것임 목적 자체가 (2번째 CPU가 사용하기 위해 공용 영역 힙에 저장)이거 이기 때문에 그래서 클로저 Reference Counting 0
 5. 클로저 사라지면서 클로저가 가리키는 vc 인스턴스는 Reference Counting 0
 6. vc 인스턴스 사라짐과 동시에 소멸자 print("\(name) 메모리 해제") 실행
 */

/**=======================================================
 - (글로벌큐)클로저가 강하게 캡처하기 때문에, 뷰컨트롤러의 RC가 유지되어
    로컬 함수의 영역에서 뷰컨트롤러를 가르키는 변수가 해제되었음에도,
    3초뒤에 출력하고 난 후 실제 뷰컨트롤러가 해제됨
    (강한 참조 순환이 일어나진 않지만, 뷰컨트롤러가 필요없음에도 오래 머무름)
=========================================================**/
/*:
 ---
 * Weak Reference(약한 참조)의 경우
 ---
 */
class ViewController1: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        // 강한 참조 사이클이 일어나지 않지만, 굳이 뷰컨트롤러를 길게 잡아둘 필요가 없다면
        // weak self로 선언
        DispatchQueue.global().async { [weak self] in
            //guard let weakSelf = self else { return }     // 사용시 print("글로벌큐에서 출력하기: \(self?.name)") 출력 되지 않음 그전에 뷰컨 인스턴스 사라져서 탈출 하기 때문임
            sleep(3)
            print("글로벌큐에서 출력하기: \(self?.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction1() {
    let vc = ViewController1()
    vc.doSomething()
}


localScopeFunction1()

// 뷰컨 메모리 해제
// (3초후)
// 글로벌큐에서 출력하기: nil

/*
 1. localScopeFunction1 함수 실행시 vc 변수에 ViewController1() 인스턴스 하나 생성 vc 인스턴스는 Reference Counting 1
 2. vc.doSomething() 과 동시에 클로저를 힙에 생성 (2번째 CPU가 사용하기 위해 공용 영역 힙에 저장) 클로저가 vc 인스턴스를 캡처하긴
 하지만 약한 참조라 여전히 vc 인스턴스는 Reference Counting 1
 
 3. localScopeFunction1 함수 종료 되면서 vc 변수 사라지고 vc 인스턴스는 Reference Counting 0
 왜냐 클로저 실행해야 하는데 3초간 기다리는 함수가 있어서 그전에 1cpu 스택에서 localScopeFunction1 함수 종료 되고 vc 변수또한 삭제되어
 vc 인스턴스는 Reference Counting 0 즉 클로저에서 캡처해서 가리키는 인스턴스가 nil로 변함 이와 동시에 : 뷰컨 메모리 해제 출력
 
 4. 두번째 cpu 스택에서 해당 클로저를 사용하여(-> vc인스턴스를 이용해야 하는데 nil) sleep함수 스택에 올라가고 사라지고
 print()함수 올라가서 클로저를 이용하여 vc인스턴스를 이용해야 하는데 nil이라 nil을 출력함   : 글로벌큐에서 출력하기: nil
 그리고 이 클로저 함수가 종료 되면서

 5. 클로저 사라지면서 클로저가 가리키는 vc 인스턴스는 Reference Counting 0       힙에서 둘다 사라짐
 */

/**=======================================================
 - 뷰컨트롤러를 오래동안 잡아두지 않음
 - 뷰컨트롤러가 사라지면 ===> 출력하는 일을 계속하지 않도록 할 수 있음
   (if let 바인딩 또는 guard let 바인딩까지 더해서 return 가능하도록)
=========================================================**/


// Strong Reference(강한 참조)의 가변참조 사이클이 일어나는것은 아닌데 뷰컨 인스턴스를 길게 잡아놓음
// Weak Reference(약한 참조)의 경우 해당 뷰컨 인스턴스를 사용해야 하는데 그전에 종료가 되버림
// 이러한 현상이 일어나는것을 알고 있어야함 그래야 알맞게 사용할수가 있는 것임

/*
 3초뒤 출력하고 싶을때는 강한 참조를 사용해야 하며
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
