//
//  ViewController.swift
//  DiceGame
//
//  Created by 정정욱 on 2023/01/09.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    //스토리보드랑 연결 되어 있지 않아도 코드 작성 가능함
    
    //[UIImage] 이렇게 타입을 줘야 이미지 리터럴을 배열에 담을 수 있음
    // #imageLiteral() 이미지 리터럴
    var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6") ]
    
    
    // 앱의 화면에 들어오면 가장 먼저 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        firstImageView.image = diceArray[1]
        secondImageView.image = diceArray[1]
      
    }

    @IBAction func rollButtonTapped(_ sender: UIButton) {
      // 첫번째 이미지뷰의 이미지를 랜덤으로 변경
    
        // firstImageView.image = // 랜덤 이미지
        firstImageView.image = diceArray.randomElement()
        
        
        // 두번째 이미지뷰의 이미지를 랜덤으로 변경
        secondImageView.image = diceArray.randomElement()
    }
    
    
    
    
}

