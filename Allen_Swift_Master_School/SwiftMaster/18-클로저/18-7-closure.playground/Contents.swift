import UIKit

/*:
 ## 캡처 현상
 * 일반적인 함수
 ---
 */
// 함수 내에서 함수를 실행하고, 값을 리턴하는 일반적인 함수

func calculate(number: Int) -> Int {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    let result = square(num: number)
    
    return result
}


calculate(number: 10)
calculate(number: 20)
calculate(number: 30)



/*:
 ---
 * 변수를 캡처하는 함수(중첩 함수의 내부 함수) - 캡처 현상의 발생
 ---
 */
/**=======================================================
 - 아래와 같은 경우, 중첩함수로 이루어져 있고
 - 내부 함수 외부에 계속 사용해야하는 값이 있기 때문에 캡처 현상이 발생
 
 - (함수/클로저를 변수에 저장하는 시점에 캡처) ==> 클로저도 레퍼런스 타입
=========================================================**/


func calculateFunc() -> ((Int) -> Int) {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    return square
}


// 함수를 변수에 할당하는 경우
// (Heap 메모리에 유지를 해야함. 즉, 함수라 하더라도 클로저 방식으로 동작)
var squareFunc = calculateFunc()


squareFunc(10)
squareFunc(20)
squareFunc(30)




/*:
 ## 클로저 캡처 리스트
 * 캡처리스트의 형태
 ---
 */
/**===========================================================
 - 1) 파라미터가 없는 경우

     { [캡처리스트] in

     }


 - 2) 파라미터가 있는 경우

     { [캡처리스트] (파라미터) -> 리턴형 in

     }
 =============================================================**/
/*:
 ---
 * 밸류(Value) 타입 캡처와 캡처리스트
 ---
 */
// 클로저는 자신이 사용할 외부의 변수를 캡처함

var num = 1


let valueCaptureClosure = {
    print("밸류값 출력(캡처): \(num)")
}


num = 7
valueCaptureClosure()   // 몇을 출력할까요?


// 밸류타입의 참조(메모리주소)를 캡처함
// (즉, 값 자체를 복사해서 가지고 있는 것이 아니고, num의 주소를 캡처해서 계속 사용)


num = 1
valueCaptureClosure()






let valueCaptureListClosure = { [num] in      // 캡처리스트에서 밸류(value) 타입 캡처
    print("밸류값 출력(캡처리스트): \(num)")
}



num = 7
valueCaptureListClosure()      // 몇을 출력할까요?
// 아까랑 다르게 주소를 복사해서 가지고 있는 것이 아니라 값 자체를 복사함 (해당 스택에 아까는 메인 함수 스택에 num  주소를 복사 했지만
// 여기서는 그냥 값만 복사해서 1 그대로 나오는 것임 값 그대로를 가지고 있음)


// 밸류타입의 값을 캡처함
// (즉, 값 자체를 복사해서 가지고 계속 사용)

// 즉, 값 타입에서는 참조하는 값의 변경을 방지(외부적인 요인에 의한)하고 사용하고자 할때, 사용

/*
 캡처현상(값 타입 캡처 현상): 클로저는 (클로저의 주기동안 사용이 필요 없어질때까지) 힙(Heap)의 영역에 존재해야하고,
 (클로저)내부에서 외부에 존재하는 변수를 계속 사용해야 하기때문에 캡처 현상이 발생 (무조건) 벨류 타입인 경우에 (필수적으로 필요한 변수 같은 것이)
 
 캡처리스트 사용시 : 클로저 외부에 존재하는 밸류타입의 값을 복사해서 사용 (외부요인에 의해 해당 값의 변경을 방지할때 사용)
 클로저를 변수에다 담는 시점에 값을 캡처해서 담는 것임 힙 영역에 (주소를 캡처하는 것이 아니라 )
 */

/*:
 ---
 * 참조(Reference) 타입 캡처와 캡처리스트
 ---
 */
class SomeClass {
    var num = 0
}


var x = SomeClass()
var y = SomeClass()

print("참조 초기값(시작값):", x.num, y.num)




let refTypeCapture = { [x] in
    print("참조 출력값(캡처리스트):", x.num, y.num)
}

/**============================================
  x - (참조타입) 주소값 캡처, x를 직접참조로 가르킴
  y - 변수를 캡처해서, y변수를 가르킴(간접적으로 y도 동일)
==============================================**/

// 즉 x는 해당 들어오는 메인 함수 안에 있는 변수에 주소를 캡처해서 힙 내부에 있는 x 인스턴스 자체를 가리키는 것이고
// y는 기존에 변수를 캡처 했던거처럼 메인 함수에 있는 y 그자체를 가리키게 되는 것임 하지만 y도 주소를 가지고 있음
// 그래서 y같은 경우에는 원래부터 캡처현상이 발생하고 메인함수에 y주소를 가르키는데 y안에는 인스턴스 y주소가 있어서 결론적으로
// 힙안에 y인스턴스를 가리키는 것 그래서 y 같은경우는 한번 거쳐서 인스턴스를 가리키는 것이고 x 같은 경우는 그 주소값을 직접적으로 담아서
// 힙 클로저 자체에서 힙 x 인스턴스를 바로 가리키게 되는것임
/*
힙 클로저 주소
데이터 영역 < --- 함수 [메모리 주소]
                x   [x주소] : 힙에서 힙을 가리킴
                y   [y주소] : y변수 주소 일단 메인을 즉 함수 스택 부분안에 y변수주소를 가리키고 -> 이 y가 힙에 y를 가리킴
 */

x.num = 1
y.num = 1

//x = SomeClass()
//y = SomeClass()

print("참조 초기값(숫자변경후):", x.num, y.num)      // 1, 1

refTypeCapture()                                // 1, 1     (Not) 0, 1

print("참조 초기값(클로저실행후):", x.num, y.num)     // 1, 1

// 그래서 결론적으로 값을 바꿔도 동일한 결과가 나오는 것임

/*
 let refTypeCapture = { [x] in
     print("참조 출력값(캡처리스트):", x.num, y.num)
 }
 
 [x] 이런식으로 사용할때는 강하게 가리키는 것임 즉 상대방에 레퍼런스 카운팅을 올린다는 것임 즉 여기서는
 x의 레퍼런스 카운팅을 올림 그래서 강한 참소 사이클의 문제가 발생할 수 있음 물론 지금 코드에서는 클래스가 클로저를 가리키고 있지 않아서
 발행하지는 않음
 
 +
 let refTypeCapture = { [x] in
     print("참조 출력값(캡처리스트):", x.num, y.num)
 }

 이코드는 실질적으로 x인스턴스의 카운트가 2번인 것임 힙에서 한번 메인 변수에서 한번
 */
/*:
 ---
 * 강한 참조 사이클 문제의 해결 - 캡처리스트 + weak/unowned
 ---
 */
// 참고로 벨류타입을 캡처할때는 원래부터  weak/unowned를 해줄 필요가 없음 어짜피 상대방에 레퍼런스 카운트를 올라가게 하거나 이런게 없기 때문임
 

var z = SomeClass()



let refTypeCapture1 = { [weak z] in // week으로 선언시 약한 참조를 하게 됨
    print("참조 출력값(캡처리스트):", z?.num) // 약한참조시 주의해야할게 가리키는 객체나 인스턴스가 없어지면 반드시 nil을
    // 할당 할수 있어야해서 이 타입이 옵셔널로 바뀌어져야함 그래서 이클로저 안에서 사용하는 z같은 경우는 옵셔널 타입으로 바뀜
    // 그렇기 때문에 ?를 붙여줘야함
}

refTypeCapture1()                        // Optional(0)



let refTypeCapture2 = { [unowned z] in
    print("참조 출력값(캡처리스트):", z.num)
}

refTypeCapture2()                        // 0




/*:
 ---
 * 캡처리스트에서 바인딩하는 것도 가능
 ---
 */

var s = SomeClass()


let captureBinding = { [z = s] in   // 내부에서 변수명 바꿔서 사용가능 (외부변수와 헷갈리는 것을 방지)
    print("바인딩의 경우:", z.num)
}


let captureWeakBinding = { [weak z = s] in
    print("Weak 바인딩 경우:", z?.num)
}



captureBinding()
captureWeakBinding()




/*
 캡처 현상이라는 것은
 [외부 변수의 주소를 캡처/보관] 그냥 무조건 외부 변수의 주소를 복사하는 것임
 클로저는 (클로저의 주기동안 사용이 필요 없어질때까지) 힙(Heap)의 영역에 존재해야하고, 내부에서 (클로저) 외부에 존재하는 변수를 계속 사용해야 하기때문에 캡처 현상 발생
 
 근데 캡처리스트를 사용할때는 차이가 있는 것임 값 형식일때는 값 자체를 직접적으로 복사 해서 담고
 참조 형식인 경우에는 메모리주소를 직접적으로 복사해서 담는 것임 (직접 담아서 바로 힙에서 힙 인스턴스를 가리킴)
    단점은 참조형식을 이렇게만 사용하면 상대방에 레퍼런스 카운팅을 증가시켜버림 긍정적으로 사용할 수도 있겠지만
 누수현상을 방지하기 위해서 weak/unowned 키워드를 사용 할 수 있는 것임
 가르키는 참조타입(인스턴스)의 RC를 올라가지 않게 함
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
