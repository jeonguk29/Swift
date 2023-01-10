//
//  main.swift
//  RamdomBingo
//
//  Created by 정정욱 on 2023/01/10.
//

import Foundation



// 앱을 처음 만드면 무조건 이 main 함수 즉 main.swift가 시작 되는 것임
/*
 근데 우리가 이제것 앱을 만들 었을 때 이 main 함수가 없었음
 사실 AppDelegate.swift 파일안에
 @main 키워드가 main.swift와 동일한 역할을 하는걸 알려주는 것임
 + 이 키워드가 붙은 부분이 앱을 실행시킬때 처음으로 실행되는 부분임

 
 커맨드 + 시프트 + y : 콘솔 영역 올라오는데 그부분에 값을 입력할수 있도록 만든 함수가 readLine()함수임
 */


var computerChoice = Int.random(in: 1...100)
var myChoice : Int = 0

while true { // 명확한 반복 횟수 모를 때는 이와 같이 조건에 의한 반복인 while문 사용
    
    var userInput = readLine()
    
    if let input = userInput { // 옵셔널 문자열 한번 풀고
        if let number = Int(input){ // 정수형으로 변환 하는 과정에서 한번 더 풀어야 정수 값을 받을 수 있음
            myChoice = number
        }
    }
    
    //print(myChoice)
    
    if computerChoice > myChoice {
        print("UP")
    } else if computerChoice < myChoice{
        print("Down")
    } else {
        print("Bingo")
        break // 반복문을 종료
    }
}

//더이상 잃을 코드가 없으니 프로그램 종료
