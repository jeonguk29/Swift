//
//  ViewController.swift
//  RPSGame
//
//  Created by 정정욱 on 2023/01/09.
//

import UIKit

class ViewController: UIViewController {
    //변수 / 속성 (class 관점에서)
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))! // 0 부터 2 까지는 확실하게 있으니까 강제로 푼것
    var myChoice: Rps = Rps.rock
    
    // 함수 / 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1) 첫번째/두번째 이미지뷰에 준비(묵) 이미지를 띄워야함
        comImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = UIImage(named: "ready.png")
        // 이처럼 이미지 삽입은 2가지로 가능 이미지 리터럴 이용 및 네임드 즉 에셋 폴더에 있는 파일 이름 입력
        
        // 2) 첫번째/두번째 레이블에 "준비"라고 문자열을 띄워야함
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
       
    }
    
   // 관습적으로 함수를 여기 아래다 변수를 위에다 작성함
    
    
    /* 가위 버튼에 연결한 액션이 바위랑 보에도 동일하게 사용 가능 하기때문에 버튼 3개에 액션 하나를 연결 시켜줌 방법 처음만 끌어서 연결 시키고 그다음 좌측 연결 확인 하얀공을 선택하여 역으로 스토리 보드에다 끌어서 연결 시켜주면 됨
    */
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        
        // 여기서 가위, 바위, 보(enum) 중 어떤게 눌렸는지 그 정보를 저장해야됨
        // _ sender: UIButton 그래서 이런 파라미터가 존재하는 것임
        // sender.currentTitle 이렇게 하면 현제 누른 버튼의 타이틀 문자열이 넘어옴
        //guard let title = sender.currentTitle else{
        //return
        //}
        
        let title = sender.currentTitle! // 이렇게 사용하려면 버튼들이 default로 설정되어 있어야함 plain으로 되어 있으면 재대로 못가져옴
        
        switch title {
        case "가위" :
            myChoice = Rps.scissors
        case "바위" :
            myChoice = Rps.rock
        case "보" :
            myChoice = Rps.paper
        default:
            break
        }
       
    }
    

    @IBAction func selectButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터가 랜덤 선택한 것을 이미지뷰에 표시
        // 2) 컴퓨터가 랜덤 선택한 것을 레이블에 표시
        switch comChoice {
        case Rps.rock:
            comImageView.image = #imageLiteral(resourceName: "rock")
            comChoiceLabel.text = "바위"
        case Rps.paper:
            comImageView.image = #imageLiteral(resourceName: "paper")
            comChoiceLabel.text = "보"
        case Rps.scissors:
            comImageView.image = #imageLiteral(resourceName: "scissors")
            comChoiceLabel.text = "가위"
        }
        
        // 3) 내가 선택한 것을 이미지 뷰에 표시
        // 4) 내가 선택한 것을 레이블에 표시
        switch myChoice {
        case Rps.rock:
            myImageView.image = #imageLiteral(resourceName: "rock")
            myChoiceLabel.text = "바위"
        case Rps.paper:
            myImageView.image = #imageLiteral(resourceName: "paper")
            myChoiceLabel.text = "보"
        case Rps.scissors:
            myImageView.image = #imageLiteral(resourceName: "scissors")
            myChoiceLabel.text = "가위"
        }
        
        // 5) 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 이겼는지/졌는지 판단/표시
        
        if myChoice == comChoice {
            mainLabel.text = "비겼다"
        }else if comChoice == .rock && myChoice == .paper {
            mainLabel.text = "이겼다"
        }
        else if comChoice == .paper && myChoice == .scissors {
            mainLabel.text = "이겼다"
        }
        else if comChoice == .scissors && myChoice == .rock {
            mainLabel.text = "이겼다"
        } else {
            mainLabel.text = "졌다"
        }
        
        
    }

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터가 다시 준비(묵) 이미지를 표시
        // 2) 컴퓨터가 다시 "준비"라고 문자열을 띄워야함
        comImageView.image = #imageLiteral(resourceName: "ready")
        comChoiceLabel.text = "준비"
        
        // 3) 내 선택 다시 준비(묵) 이미지를 표시
        // 4) 내 선택 다시 "준비"라고 문자열을 띄워야함
        
        myImageView.image = #imageLiteral(resourceName: "ready")
        myChoiceLabel.text = "준비"
        
        // 5) 메인 레이블 "선택하시오" 표시
        mainLabel.text = "선택하시오"
        // 6) 컴퓨터가 다시 랜덤 가위/바위/보를 선택하고 저장
        
        comChoice = Rps(rawValue: Int.random(in: 0...2))!
    }
    
}


