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
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
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
        
        guard let bmi = bmiNumber else { return }
        bmiNumberLabel.text = String(bmi)
        
        // 전달받은 데이터들 어짜피 들어가는 타입이 옵셔널 타입이라 굳이 벗겨서 넣을 필요 없음
        bmiNumberLabel.backgroundColor = bmiColor
        adviceLabel.text = adviceString
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
