//
//  SecondViewController.swift
//  BMI
//
//  Created by 정정욱 on 2023/03/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    
    @IBOutlet weak var adviceLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    // 전달 받을 데이터들
//    var bmiNumber: Double?
//    var adviceString: String?
//    var bmiColor: UIColor?
    
    var bmi: BMI? // 값이 넘어올때도 구조체로 만들었으니 구조체 하나만 전달 받으면 되는 것임
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
        
    }
    
    func makeUI(){
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        backButton.setTitle("다시 계산하기", for: .normal)
        
        
        guard let bmi = bmi else { return }
        // 전화면에서 전달받은 BMI를 통해 셋팅
        bmiNumberLabel.text = "\(bmi.value)"
        bmiNumberLabel.backgroundColor = bmi.matchColor
        adviceLabel.text = bmi.advice
        
        // 이전 코드를 수정한다면
//        guard let bmi = bmi else { return }
//        bmiNumberLabel.text = String(bmi.value)
//
//        // 전달받은 데이터들 어짜피 들어가는 타입이 옵셔널 타입이라 굳이 벗겨서 넣을 필요 없음
//        bmiNumberLabel.backgroundColor = bmi.matchColor
//        adviceLabel.text = bmi.advice
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
