import UIKit


var number : Int? = 7
var hello : String? = "안녕하세요"
var name : String? = "홍길동"
var newNum : Double? = 3.5

print(number)
print(hello)
print(name)
print(newNum)



if let num = number{ // num이라는 상수는 스코프 범위가 이 if문 안이라 다른 if let 바인딩에서도 같은 이름 사용가능
    print(num)
}

if let num = hello{
    print(num)
}

if let num = name{
    print(num)
}

if let num = newNum{
    print(num)
    let num = "ih"
    print(num)
}


func doSomething(i: Int?, name: String? ) {
    guard let n = name else { return }
    print(n) //어떻게 같은 이름이 사용가능
    
    guard let n = i else { return }
    print(n)
    /*
     스위프트에서 옵셔널 바인딩이라는 개념때문에 편리하게 기존의 상수를 그냥 옵셔널 바인딩만해서 사용하는 것처럼 사용하라고 이런 방식도 허용해 주고 있음
     
     */
}

doSomething(i: 3, name: "hi")

/*
 Optional("홍길동")
 Optional(3.5)
 7
 안녕하세요
 홍길동
 3.5
 hi
 3
 */

/*
 
 정정욱
   오전 2:44
 엘런 질문이 있어요 44-1강을 보면서 if-let, guard-let
 바인딩에 사용한 상수 범위에 대해서 공부하고 있는 중인데 아래 코드를 보면 if-let에 사용한 변수 num은
 각 if 문 범위 내에서만 사용하고 끝나기 때문에 아래와 같은
 로직을 가질 수 있는 것을 이해했어요 근데 guard-let 바인딩을 doSomething이라는 함수 안에서 아래와 같이 사용할 때 어떻게 n이라는 이름에 상수를 또다시 사용할 수 있는 걸까요? 처음 n의 범위는 함수의 {} 범위 아닌가요?
 
 앨런(Allen)
   오전 2:45
 네네 맞아요 가드문은... 바인딩 한 후의 변수(상수)의 범위가 아래 코드로 이어집니다. 그게 가드문의 약속이예요! (그렇게 사용하기 위해, 가드문을 사용하는 것이고요.)
2:47
주교재에 233 페이지에 적어놓긴했는데, 아래 문장이 동일한 스코프로 취급이 됩니다.


정정욱
  오전 2:48
아 그런데 n이라는 상수 이름으로 바인딩을 먼저 했으니까 아래 코드에서는 n이라는 동일한 이름으로 바인딩이 되면 오류가 나야 하는게 아닐까 생각 하고 있어요


앨런(Allen)
  오전 2:50
아아..! 사실 그것도 가능해요 원래 범위라는게, 예를 들어서 함수 내부에 n이 선언되어있고, 함수 바깥에 n이 선언되어 있으면... 일단 가장 인접한 n을 사용하는 것이잖아요!
근데, 옵셔널 바인딩에서는.. 그런것도 허용을 시켜줘서... 동일한 n을 선언해도 가드문에 있는 가장 인접한 n으로 사용이 가능해요 !!




정정욱
  오전 2:51
아아 감사해요!!! 머리에 확 개념이 잡혔어요!!




앨런(Allen)
  오전 2:51
조금 특이하긴 한데, 스위프트에서 옵셔널 바인딩이라는 개념때문에.. 편리하게 기존의 상수를 그냥 옵셔널 바인딩만해서 사용하는 것처럼 사용하라고.. 이런 방식도 허용해 주고 있습니다... :미소짓는_얼굴:
*/

