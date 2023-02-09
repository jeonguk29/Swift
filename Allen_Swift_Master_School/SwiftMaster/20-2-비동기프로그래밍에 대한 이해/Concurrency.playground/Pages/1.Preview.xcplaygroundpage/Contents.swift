import Foundation
import PlaygroundSupport
// 플레이 그라운드 작업 중간에 멈추지 않게 하기 위함
// (비동기작업으로 인해, 플레이그라운드의 모든 작업이 끝난다고 인식할 수 있기때문에 사용)
PlaygroundPage.current.needsIndefiniteExecution = true


/*
 비동기 동기, 직렬 병렬

 비동기 (Async) 작업을 다른 쓰레드에서 하도록 시킨후 그 작업이 끝나길 “안 기다리고” 다음일을 진행한다.
 (안 기다려도 다음 작업을 생성할 수 있다.)

 동기 (Sync) 작업을 다른 쓰레드에서 하도록 시킨후, 그작업이 끝나길 “기다렸다가” 다음일을 진행한다.
 (기다렸다가 다음 작업을 생성할 수 있다.)

 비동기 처리시(메인 쓰레드가 아닌 다른 쓰레드에 작업을 보내는 방식)
 직렬(Serial)처리 (보통 메인 쓰레드에서) 분산처리 시킨 작업을 “다른 한개의 쓰레드에서” 처리

 동시(Cocurrent)처리 (보통 메인 쓰레드에서) 분산처리 시킨 작업을 “다른 여러개의 쓰레드에서” 처리

 즉 비동기 처리시 하나의 쓰레드에 작업을 모두 보낼때 직렬처리(직렬큐 처리) 여러 쓰레드에 작업을 나눠 보낼때(동시큐 처리)
 직렬 : 순서가 중요한 작업을 처리할때 사용
 동시 : 각자 독립적이지만 유사한 여러개의 작업을 처리할때 사용
 
 -------------------------
 비동기란 말과 동시란 말은 같은 말인가?
 비동기라는 말은 작업을 보내는 쓰레드에 관련된 말임 메인 쓰레드에서 다른 쓰레드에 보낸 작업을 기다릴지 말지에 대한 개념이 동기, 비동기
 // 작업을 동기(순차) 처리할지 다른 쓰레드에 나누어 동시/직렬처리 할지(비동기 처리)
 
 동시/직렬은 비동기 처리시 메인 쓰레드에서 작업을 보낼때 1개에 쓰레드에 다 보내냐 여러개의 쓰래드로 나누어 보내냐 할때 쓰는 개념임

 
 이러한 것을 비동기처리/ 동시성 프로그래밍이라고 함
 즉 분산처리를 어떻게 하는지에 대한 코딩 방법 -> 비동기 처리 / 동시성 프로그래밍
 (iOS에서 소프트웨어적 쓰레드를 처리하는 방법임)
 
 네트워크 처리 대한 개념을 배우면서, 마주하게 되는 개념
 네트워크 처리에서 사용예시 ex 인스타그램 같은 앱에서 게시물 보여줄때
 메인Thread: 1초에 60번 화면을 다시 그려야 하는 역할도 하기 때문에 너무 오래 걸리는 작업들을 시키면 안된다.
 그래서 그냥 비동기적으로 처리시 메인 쓰레드에서 일처리하면서 빈시간에 화면도 그려야해서 버벅거리면서 화면이 보여짐
 대안 : 비동기 처리
 
 -----------------------------------------------
 병렬과 동시성의 개념
 
 우선 물리적 쓰레드, 소프트웨어 쓰레드 개념부터 알고가자
 실제 8코어 16쓰레드 라고 컴퓨터 사양이 적혀있어도 작업을 16개로 나누어처리 한다는 것은
 물리적인 관점에서 쓰레드 즉 물리적 쓰레드를 말함 (실제 물리적인 계산을 실행)
 cpu 1초에 30억번 일을 처리 하는데 실제로 앱단위에서 30억번 일처리 시킬 수가 없음 그래서 OS영역에서
 실제 물리적 쓰레드를 나누어 하나당 N0억번 일처리를 하게 만들어버림 (만든걸 쓰레드 풀에서 관리함)즉 물리적 쓰레드하나가 따로 따로 일을 하는 것 처럼 만듬 (물리적 쓰레드 하나를 나누어서 )실질적으로 그럼 앱이 실행 될때 OS영역에 쓰레드 풀에서 물리적 쓰레드를 나눈것중 하나를 메인 쓰레드로 채택을 하고 비동기 처리시 직렬/동시적으로 처리할때 즉 비동기적 처리가 필요할때 직렬/동시처리 할지를 정해서 DispatchQueue(큐에 넣어주면 OS가 알아서 동시 처리해줌 몇개의 소프트웨어 쓰레드를 쓸지도)를 통하여 직접적으로 쓰레드를 관리하는 개념이 아닌, 대기열(Queue)의 개념을 이용해서, 작업을 분산처리하고, OS에서 알아서 쓰레드 숫자(갯수)를 관리함
 즉 비동기 처리가 필요할때 큐에 넣어서 몇개에 쓰레드가 필요하겠군아 알아서 OS가 처리한다음 필요한 만큼만 쓰레드 풀에서 가져다 쓰고 반납하는 구조인 것임
  
 그래서 다시 정리하면
 병렬(Parallel)
 물리적인 쓰레드에서 실제 동시에 일을 하는 개념
 
 동시성(Concurrency)
 메인 쓰레드가 아닌 다른 소프트웨어적인 쓰레드에서 동시에 일을 하는 개념
 물리적인 쓰레드를 알아서 switching하면서 엄청나게 빠르게 일을 처리
 (예를 들어, 2개의 쓰레드에서 일을해도 내부적인 물리적인 쓰레드는 1개만 동작 하고 있을 수도 있음)
 
 즉 동시적으로 일을 할 수 있지만 소프트웨어적 쓰레드 관점에서 실제 물리적 쓰레드 관점에서는 병렬처리가 아닌
 물리적 쓰레드 하나만 일을 하고 있을 수도 있다는 것을 알고 있어야함
 
 
 요약 동기/비동기(쓰레드 제어권 기다릴지 말지 : 순차처리할지/ 여러개로 나누어 분산처리할지) 만약 비동기 처리를 한다고 하면 거기서 다시 동시/직렬처리(몇개 쓰레드로 나눌지)
 동시는 소프트웨어적인 쓰레드에서 쓰레드 여러개에 작업을 나누어 동시에 일을 하는 개념 / 만약 비동기 처리인데 직렬처리시 작업을 분산처리 하지만 하나의 쓰레드에 전체 작업을
 다 보내는 것임 이 작업은 순차처리 / 병렬은 물리적 쓰레드에서 일을 동시에 처리하는 개념
 
 iOS에서는 개발자가 물리적 쓰레드를 관리 할 필요 없으며 (OS가 알아서 해줌) 소프트웨어적 쓰레드만
 동기/비동기 처리 할지 내부적으로 큐를 활용하여 동시/직렬 처리할지에(동시큐 직렬큐 쓸지 정해서 큐에 보내면 알아서 다해줌 몇개의 소프트웨어적 쓰레드를 쓸지도 다 알아서...) 대해서 생각하면 됨
 
 
 */
//: # 빨리 끝나는 작업들
//: ### 다른 쓰레드를 사용해야할지에 대해 인지하지 못했던 간단했던 작업들
// 간단한 프린트 작업 예시 (컴퓨터, 아이폰은 이정도 작업들은 금방 처리 가능)

func task1() {
    print("Task 1 시작")
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    print("Task 3 완료★")
}

func task4() {
    print("Task 4 시작")
    print("Task 4 완료★")
}

func task5() {
    print("Task 5 시작")
    print("Task 5 완료★")
}


task1() // 쓰레드 위치
task2()
task3()
task4()
task5()

// 지금 이 작업은 1번 쓰레드 즉 메인 쓰레드에서만 다 처리함  것임


//: # 오래 걸리는 작업들
//: ### 이제 네트워킹과 같이 오래걸리는 작업이 있다면
// 함수가 임의적으로 오래걸리도록 정의


func task6() {
    print("Task 6 시작")
    sleep(2)
    print("Task 6 완료★")
}

func task7() {
    print("Task 7 시작")
    sleep(2)
    print("Task 7 완료★")
}

func task8() {
    print("Task 8 시작")
    sleep(2)
    print("Task 8 완료★")
}

func task9() {
    print("Task 9 시작")
    sleep(2)
    print("Task 9 완료★")
}

func task10() {
    print("Task 10 시작")
    sleep(2)
    print("Task 10 완료★")
}



// 비동기처리를 하지 않으면 10초이상이 걸림

task6()
task7()
task8()
task9()
task10()


// 즉 네트워크 작업 같은 것은 이런방식과 유사하다는 것임 실제로 앱에서 이런다면
// 앱의 화면이 버벅거린다는 것임

//: ### 오래 걸리는 작업을 비동기 처리를 한다면
print(1)
// 이렇게 큐에 보내는 코드만 적어주면 됨
DispatchQueue.global().async { // sync 라고 쓰면 동기적 처리하겠다알려 주는 것임
    task6()
}// 이 클로저 안에 코드를 비동기적으로 처리 할거야라고 알려주는 것임


DispatchQueue.global().async {
    task7()
}

DispatchQueue.global().async {
    task8()
}

DispatchQueue.global().async {
    task9()
}

DispatchQueue.global().async {
    task10()
}
print(2)
// 위에 동기로 처리한 코드는 10초가 걸리지만 이렇게 비동기로 처리한 함수는 2초안에 모든 작업이 다끝남
// 비동기적 처리했기 때문에 비동기적 처리 코드의 순서 예상 할 수 없음 어떤쓰레드에 위치되서 먼저 끝날지 모름
// 그리고 2가 먼저 출력이 안될 수 있다는 걸 알아야함 여기 코드에서는 2초 기다리기 때문에 2가 먼저 나오는걸
// 알고 있어야함
// 동기적으로 시키면 기다리기 때문에 위에 코드와 마찮가지로 10초 걸리고 앱에서 실행시 버벅거릴 수 밖에 없음
// 그래서 대부분 async만 씀 sync 사용은 의미가 없음 이단원을 배우는 이유가



sleep(4)
// 작업이 종료되었으니 플레이그라운드 실행 종료 Ok.
PlaygroundPage.current.finishExecution()
//: [Next](@next)
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
