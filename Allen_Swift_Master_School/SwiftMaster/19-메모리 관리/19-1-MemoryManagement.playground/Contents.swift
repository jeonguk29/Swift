import UIKit

/*:
 # Part19 - 메모리 관리
 */
/*:
 ## ARC(Automatic Reference Counting)를 통한 메모리 관리
 * MRC(Manual RC) vs ARC(Automatic RC)
 ---
 */
/*
 코드, 데이터, 힙, 스택 영역중에서 코드 영역은 한번 코드가 올라가는 순간 리드온리 영역임 바뀌지 않음. 따로 관리 필요가 없음
 데이터 영역도 클래스 즉 붕어빵 틀이 중간에 바뀔수 없음 : 앱이 실행되는 동안 불변 영역임 다시말해 우리가 크게 신경 쓰지 않아도 되는 영역이고
 스택영역 또한 에초에 값타입을 사용할때 빠르게 생성되고 삭제되는 영역임 해당 함수가 스택영역에서 올라와 있는 동안 종료시점 까지
 알아서 잘 관리가 되는데 힙영역 같은 경우는 개발자가 신경을 써줘야함 클래스에 인스턴스 같은 것을 찍어낼때 동적 할당이 일어나는데 (힙 영역중 비어있는 영역을 찾아서 그 영역에 생성함) 힙영역 스캔후 비어있으면 할당 (생성하고) 이런식이기 때문에 느릴수 밖에 없다고 했음 그리고 힙영역에 저장 되는 애들은 관리 하지 않으면 메모리 누수 현상이 발생함 (메모리에서 제거되지 않는 상황 필요없는데도) 이렇게 쌓이기만 하다보면 메모리가 부족해서 앱이 꺼질 수 있음 그래서 이 힙영역을 관리 하는 방법을 알아야 함 Swift는 ARC 모델을 이용하여 관리함
 *RC(참조 숫자)를 세는 것을 통해, 메모리 관리 / 컴파일시에 메모리 해제시점을 결정
 Objective - C : MRC(Manual RC), ARC (Automatic RC) 둘다 이용 했음
 JAVA : GC (Garbage Collector) 라는 메모리 관리법을 이용함 : 가끔씩 힙 메모리를 쭉 스캔해서 여기 저장 되어 있는 것중에 이놈은 메모리는 이제 사용 안하겠군아 생각한다음에 자동으로 제거함 앱이 또 실행 되다가 가끔식 이작업을 반복을 함 자바는 모든걸 자바가 알아서 해주기 때문에
 개발자가 생각 할 필요가 없음 하지만 자동적으로 힙 메모리를 쭉 스캔 하기 때문에 필연적으로 느리다는 단점이 있음
 
 */

// MRC(수동 RC관리)와 ARC(자동 RC)

class Dog {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


var choco: Dog? = Dog(name: "초코", weight: 15.0)  //retain(choco)   RC: 1
// 생성자 내부에도 retain 명령어가 있음
var bori: Dog? = Dog(name: "보리", weight: 10.0)   //retain(bori)    RC: 1
// nil을 넣어주기 위해 옵셔널 Dog타입으로 선언함

choco = nil   // RC: 0                      주소를 가리키다가 nil을 해주면 나를 가리키는 녀석이 없어지는 것임
//release(choco)
bori = nil    // RC: 0
//release(bori)

// 옛날에는 개발자들이 이렇게 수동으로 retain(choco), release(choco) 코드 까지 다 입력해줬음 수동으로 : 정신나감

/**========================================================================
 - 예전 언어들은 모든 메모리를 수동 관리했음
 - 실제로 개발자가 모든 메모리 해제 코드까지 삽입해야함 (실수할 가능성 높음)
 

 - retain() 할당 ---> release() 해제
    (RC  +1)           (RC  -1)

 - 개발자는 실제 로직 구현 포함, 메모리 관리에 대한 부담이 있었음 ⭐️


 - 따라서, 현대적 언어들은 대부분 자동 메모리 관리 모델을 사용
 - 스위프트의 경우, 컴파일러가 실제로
   retain() 할당 ---> release() 해제 코드를 삽입한다고 보면됨
 - 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써, 프로그램의 메모리 관리에 대한 안정성 증가


 - 단지 아래와 같은 메커니즘의 실행을 수동(Manual)으로 할 것인지,
   자동(Automatic)으로 할 것인지의 차이

 [ARC모델의 기반: 소유정책과 참조카운팅]
   1.소유정책 - 인스턴스는 하나이상의 소유자가 있는 경우 메모리에 유지됨
             (소유자가 없으면, 메모리에서 제거)
   2.참조카운팅 - 인스턴스(나)를 가르키는 소유자수를 카운팅

 - (쉽게 말하면, 인스턴스를 가르키고 있는 RC가 1이상이면 메모리에 유지되고, 0이되면 메모리에서 제거됨)
 =======================================================================**/


/*:
 ---
 * ARC(Automatic Reference Counting)
 ---
 */
var dog1: Dog?
var dog2: Dog?
var dog3: Dog?


dog1 = Dog(name: "댕댕이", weight: 7.0)     // RC + 1   RC == 1
dog2 = dog1                               // RC + 1   RC == 2
dog3 = dog1                               // RC + 1   RC == 3


dog3?.name = "깜둥이"                      // 다 같은 녀석을 가리키고 있어서 깜둥이로 출력 나옴
dog2?.name
dog1?.name



dog3 = nil                                // RC - 1   RC == 2
dog2 = nil                                // RC - 1   RC == 1
dog1 = nil                                // RC - 1   RC == 0    // 메모리 해제



//RC가 0이 되는 그 시점에서야 메모리 해제가 일어남





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
