//
//  ViewController.swift
//  day1_Adding_Slider_and_HitButton
//
//  Created by 정정욱 on 2022/11/18.
//

import UIKit

class ViewController: UIViewController {
    /*
     
    변수와 상수의 저장은 임시적 프로그램 종료되면 사라짐
     변수와 상수는 {} 안에서 유효함
     */
    
    var randomValue: Int = 0 // 게임 시작시 사용자가 맞춰야할 임의에 정답 숫자
    var tryCount: Int = 0
    
    // 변경 UI 요소는 이렇게 코드 변수로 가져옴
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLable: UILabel! // 몇번 시도했는지 UI
    @IBOutlet weak var sliderValueLabel: UILabel! // 슬라이더 현제 위치 값 표시 라벨
    @IBOutlet weak var minimumValueLabel: UILabel! // 슬라이더 최소 값 표시 라벨
    @IBOutlet weak var maximumValueLabel: UILabel! // 슬라이더 최대 값 표시 라벨
    //!!! 변수 즉 아울렛이던 액션 이름이던 바꿀때는 우클릭 리팩터로 바꿔 주기 그래야 다른 곳 적용된 이름들도 다 바뀜
    
    
    // Actions and Outlet
    
    // 아울렛은 인터페이스 빌더에 올라와 있는 UI요소의 값을 가져오고 싶을때 그것을 코드에서 활용하고 싶을때 사용
    // 액션은 인터페이스 빌더에 어떤 이벤트를 받았을때 거기에 반응하기 위한 액션 코드를 작성하기 위해 사용함
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slider.setThumbImage(UIImage(imageLiteralResourceName: "slider_thumb.png"), for: .normal)
        // 슬라이더가 평소상태일때 아무때나 이 이미지 표시
        // 스토리보드가 모든걸 다 설정해줄수는 없음 간혹가다가 이렇게 코드로 설정해줘야 하는 경우가 있음 즉 스토리보드로 100% UI 만들기 어려움
        
        reset()
    }
    
    /* 문법정리
    // func 함수이름 (파라미터){
    // 함수 구현부
    //} 이렇게 클레스안 함수는 메서드라고 함
    //    @IBAction 는 인터페이스 빌더에서 연결할 액션 함수다 라고 알려주는 것임
     viewDidLoad() 이렇게 사용하면 함수 호출 즉 사용 하겠다는 것임
     */
    
   
    
    @IBAction func sliderValueChanged(_ sender: UISlider)
    {
        print(sender.value)
        let integerValue: Int = Int(slider.value) // 슬라이더 벨류 Float 실수형을 인트형 변환후 인트형 변수에 저장
        sliderValueLabel.text = String(integerValue) // 사용자에게 소숫점 자리는 보이지 않게 하기
    }
    
    @IBAction func touchUpHitButton(_ sender:UIButton)
    {
        print(slider.value)
        let hitValue: Int = Int(slider.value)
        slider.value = Float(hitValue) // 사용자가 입력 버튼 누르면 슬라이더의 소숫점 값을 버리고 그와 유사한 Int 값에 위치 시키기 위해 이런식으로 값을 바꿔줌
        
        tryCount = tryCount + 1
        // tryCountLable.text = String(tryCount) + " / 5"
        tryCountLable.text = "\(tryCount) / 5" // 문자열 보관법 위에 코드랑 같지만 이렇게 보는게 더 직관적으로 이해하기 쉬움
        
        if randomValue == hitValue{ // 만약 임의의 숫자와 내가 선택한 숫자가 맞다면 표시
            print("YOU HIT!!")
        }
        
    }
    
    @IBAction func touchUpResetButton(_ sender:UIButton)
    {
        print("touch up Reset Button")
        reset() // 리셋 버튼 누르면 리셋 함수 실행
        
    }
    
    func reset(){
        print("reset!")
        // 초기화시 임의의 정답 값 및 도전 횟수 라벨 값 변수값 변경
        randomValue = Int.random(in: 0...30) // 0에서 30 사이에 임의에 값을 넣겠음
        print(randomValue)
        tryCount = 0
        tryCountLable.text = "0 / 5"
        // 초기화시 연결된 슬라이드 값 변경
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        // 초기회시 연결된 라벨 텍스트 변경
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
        
    }


}

