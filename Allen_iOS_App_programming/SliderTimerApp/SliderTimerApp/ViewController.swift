//
//  ViewController.swift
//  SliderTimerApp
//
//  Created by 정정욱 on 2023/03/13.
//

import UIKit
import AVFoundation // 시스템 사운드 사용시


class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    weak var timer: Timer?
    var number = 0  // 사용자 초를 저장하고 점점 뺄 값임
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mainLabel.text = "초를 선택하세요"
        configureUI() // 실무에서 사용하는 방법 코드가 훨씬 깔끔하게 정리됨
        
        // 슬라이더의 가운데 설정
    }

    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
    }

    // 슬라이더도 버튼처럼 액션, 아웃렛이 있음
    @IBAction func sliderChanged(_ sender: UISlider) {
        // 슬라이더의 벨류값을 가지고 메인레이블의 텍스트를 셋팅
        
        let seconds = Int(slider.value * 60)// 정수형태 변환시 나머지 버림
    
        mainLabel.text = "\(seconds) 초"
        
        number = seconds // 정수형 변환 시킨걸 넣어주기
   
    }
  
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초씩 지나갈때마다 무언가를 셋팅
        
        timer?.invalidate() // 비활성화 먼저 해줘야함
        // 아래 코드처럼 몇초당 반복할건지 , 클로저 안에 코드를 초당 반복 시킬건지 repeats: true 그리고 클로저 안에
        // 해당 타임마다 반복 시킬 코드를 넣어주면 됨
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
             // do something here
             // 클로저라 해당 클레스 인스턴스를 캡처 뜸 : + 문법 😀 강함 참조를 한다고 캡처리스트 명시하면 self.number 이렇게 안해도 됨 self 생략 가능 약한참조시 week self , 사용시 self?.number
             
             if number > 0{
                 number -= 1
                 // 슬라이더도 줄여줘야함
                 // 레이블 표시도 다시 필요
                 slider.value = Float(number) / Float(60) // 정수형을 다시 실수형으로 변환 이렇게 나누면 (다시 0.0 ~ 60.0 까지 나올 것임)
                 mainLabel.text = ("\(number) 초")
             }else {
                 number = 0 // number가 계속 반복후 0이 된 경우
                 mainLabel.text = "초를 선택하세요"
                 timer?.invalidate() // 위에서 타이머 계속 반복 되니까 비활성화 해줘야함 : 타이머 사용 + 반복작업 하는 경우 => 비활성화도 해줘야함
                 
                 // 사운드 코드
                 let systemSoundID: SystemSoundID = 1322

                 // to play sound
                 AudioServicesPlaySystemSound(systemSoundID)
             }
            
         }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {

        // 초기화 셋팅
        mainLabel.text = "초를 선택하세요"
        // 슬라이더의 가운데 설정
        slider.setValue(0.5, animated: true)
        number = 0
        timer?.invalidate() // 타이머 사용시 타이머 비활성화 코드를 군데 군데 넣어주는 것도 좋음

    }
    
    /*
     지금 코드 작성 한 것은 ViewController이라는 클래스 붕어빵 틀을 만든 것이고 앱을 실행할때 힙영역에 인스턴스를 찍어낸다고 생각하면 됨
     
     */
}

