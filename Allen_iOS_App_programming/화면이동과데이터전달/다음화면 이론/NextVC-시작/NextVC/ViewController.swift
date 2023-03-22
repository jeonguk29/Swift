//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        let firstVC = FirstViewController() // 일단 메모리에 생성 실제 스토리보드에서 만든게 아니라 자체적 코드로 이미 화면을 다 구성했음
        
        firstVC.someString = "Woogie" // 전 화면에서 다음 화면애 어떤 변수에다가 문자를 전달해주는 것임
        
        // firstVC.mainLabel.text = "Woogie" //이런식으로 직접 전달도 가능하지만 잘 쓰지 않음 일반적으로 위와같이 어떤 변수를 하나 만들고 거쳐 사용함
        /*
         ⭐️ 우리는 코드로 지금 만들었기 때문에 위 처럼 전달 하는게 가능 하긴 함 근데 스토리보드로 만들면 이런식으로 전달하는게 불가능함
         코드로 만드는건 메모리에 한꺼번에 올라감 모든 저장 속성이
         스토리 보드로 만들게 되면 우선 코드로 된 뷰컨트롤러를 메모리에 올리고 그다음에 스토리보드를 메모리에 올림 그다음 마지막으로
         코드랑 스토리 보드로 연결하는 과정을 거침 그러면 실제로 위와 같이 구현하면 아직 스토리보드가 메모리에 올라가기전이라고 오류가남 아직 연결 되지 않아서...
         그 연결된 시점이 viewDidLoad 인것임
         */
        
        firstVC.modalPresentationStyle = .fullScreen // 화면을 풀스크린으로 뛰움 이코드가 없으면 풀 스크린이 아니라 위에가 살짝 공백 처리 되면서 아래로 내리면 화면이 사라지게 구현됨
    
        // 이동하는 코드는 UIViewController에 이미 구현 되어있음
        // present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        // 이동할 뷰컨, 애니메이션 적용, 화면으로 다 넘어가면 무엇을 실행 할 것인지 일반적으로 화면 넘어가면 아무것도 하지 않아도 되서 nil을 많이줌
        present(firstVC, animated: true, completion: nil)
        
        
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        // 위랑 다르게 스토리보드로 UI를 생성함 즉 힙영역에 따로 스토리 보드로 만든 인스턴스가 있는 것임
        // 그런 각각의 스토리 보드를 연결을 시켜줘야함
        
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else{
            return
        }
        
        // storyboard?.instantiateViewController(withIdentifier: "secondVC") 까지는 UIViewController 라는 것이 반환(구체적이지 않음)되고 우리가 만든 클래스로 구체적 타입 캐스팅이 필요함
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.someString = "아빠상어"
        // secondVC.mainLabel.text = "아빠상어" 앱이 꺼짐 아직 스토리보드 메모리에 올라가지도 않음        :   모든 내부적 코드가 연결되기 전에 접근해서 오류남
        // someString은 SecondViewController 가 메모리에 올라갈때 생기는거니까 그순간에 아빠상어라는 데이터를 전달해주는 것임 (값을 넣고 찍어버림)
        // 그다음에 스토리보드랑 SecondViewController 인스턴스랑 연결된 다음에 그 데이터를 그려주는 것임
        present(secondVC, animated: true, completion: nil) // 사실상 스토리보드상에 각각의 화면 인스턴스를 연결 시켜주는 것임
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        

        // 세번째 버튼이 눌렸을때 화면을 이동시켜야 하는데 그걸 담당하는게 세그웨이
        performSegue(withIdentifier: "toThirdVC", sender: self) // 세그웨이 활성화 코드, sender 에는 일반적으로 보내는 놈을 써줌 ViewController
        // 이제 버튼이 눌리면 위 코드에 따라 세그웨이가 동작하는 것임
                
    }
    
    // 세그웨이를 통해 데이터 전달을 할때는 아래와 같은 메서드를 재정의하여 보내야함 ⭐️ 데이터 전달시 필수구현    :   performSegue가 자동으로 호출함
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "toThirdVC"{ // 1. 식별자 확인
            let thirdVC = segue.destination as! ThirdViewController // 2. 도착지 확인 => 구체적 타입으로 변환
                // 어떠한 도착지점인 UIViewController 를 반환해서 명확하게 알려줌 // 3. 데이터 전달
            
            thirdVC.someString = "엄마상어"
        }
    }
    

    
}

