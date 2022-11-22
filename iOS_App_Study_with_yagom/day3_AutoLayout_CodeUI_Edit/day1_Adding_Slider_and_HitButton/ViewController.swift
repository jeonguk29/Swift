//
//  ViewController.swift
//  day1_Adding_Slider_and_HitButton
//
//  Created by 정정욱 on 2022/11/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    // Actions and Outlet
    
    // 아울렛은 인터페이스 빌더에 올라와 있는 UI요소의 값을 가져오고 싶을때 그것을 코드에서 활용하고 싶을때 사용
    // 액션은 인터페이스 빌더에 어떤 이벤트를 받았을때 거기에 반응하기 위한 액션 코드를 작성하기 위해 사용함
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slider.setThumbImage(UIImage(imageLiteralResourceName: "slider_thumb.png"), for: .normal)
        // 슬라이더가 평소상태일때 아무때나 이 이미지 표시
        // 스토리보드가 모든걸 다 설정해줄수는 없음 간혹가다가 이렇게 코드로 설정해줘야 하는 경우가 있음 즉 스토리보드로 100% UI 만들기 어려움
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
    }
    
    @IBAction func touchUpHitButton(_ sender:UIButton)
    {
        print(slider.value)
        
    }
    
    @IBAction func touchUpResetButton(_ sender:UIButton)
    {
        print("touch up Reset Button")
        
    }


}

