//
//  DataManager.swift
//  TableView
//
//  Created by 정정욱 on 2023/03/31.
//

import UIKit

class DataManager{
    var movieDataArray: [Movie] = []

    func makeMovieData(){   // 일반적으로 서버와 통신 하기전에는 빈배열을 생성해두고 통신후 데이터를 채워 넣기 위해 이런식으로 구현해본것임 
        movieDataArray = [
            Movie(movieImage: UIImage(named: "batman.png"), movieName: "배트맨", movieDescription: "배트맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "captain.png"), movieName: "캡틴 아메리카", movieDescription: "캡틴 아메리카의 기원. 캡틴 아메리카는 어떻게 탄생하게 되었을까?"),
            Movie(movieImage: UIImage(named: "ironman.png"), movieName: "아이언맨", movieDescription: "토니 스타크가 출현, 아이언맨이 탄생하게된 계기가 재미있는 영화"),
            Movie(movieImage: UIImage(named: "thor.png"), movieName: "토르", movieDescription: "아스가르드의 후계자 토르가 지구에 오게되는 스토리"),
            Movie(movieImage: UIImage(named: "hulk.png"), movieName: "헐크", movieDescription: "브루스 배너 박사의 실험을 통해 헐크가 탄생하게 되는 영화"),
            Movie(movieImage: UIImage(named: "spiderman.png"), movieName: "스파이더맨", movieDescription: "피터 파커 학생에서 스파이더맨이 되는 과정을 담은 스토리"),
            Movie(movieImage: UIImage(named: "blackpanther.png"), movieName: "블랙펜서", movieDescription: "와칸다의 왕위 계승자 티찰과 블랙펜서가 되다."),
            Movie(movieImage: UIImage(named: "doctorstrange.png"), movieName: "닥터스트레인지", movieDescription: "외과의사 닥터 스트레인지가, 히어로가 되는 과정을 담은 영화"),
            Movie(movieImage: UIImage(named: "guardians.png"), movieName: "가디언즈 오브 갤럭시", movieDescription: "빌런 타노스에 맞서서 세상을 지키려는 가오겔 멤버들")
        ]
    }
    
    func getMovieData() -> [Movie]{
        return movieDataArray
    }
    
    // 구조체를 하나 생성해서 데이터에 추가하고 있음
    func updateMovieData(){
        let movie = Movie(movieImage: UIImage(named: "spiderman2.png"), movieName: "스파이더맨 시즌2", movieDescription: "스파이더맨 시즌2")
        movieDataArray.append(movie)
    }
}


