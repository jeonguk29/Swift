//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 정정욱 on 2023/01/08.
//

import UIKit

//ViewController 는 애플이 기본적으로 만든 이름이고 리팩토링 버튼을 눌러서 이름 바꿔 줄 수도 있음
// 이름 바꾸면 스토리보드와 연결된 이름도 바뀜
class MyViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    // 😆 코드 분석
    // 지금 코드를 보면 mainLabel 라는 변수에 UILabel 타입으로 선언 되어있음
    // weak 은 메모리 관리에서 약한 참조를 말하는데 스토리 보드에 UILabel이 올라가서
    // 서로 가리키는 상황이 있을 수 있기 때문에 스토리 보드에 올라가거나 관련 된것은 자동으로 weak으로 선언됨
    
    @IBOutlet weak var myButton: UIButton!
    
    
    // 앱의 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "방가방가"
        
        // 레이블 백그라운드 색상 설정
       // mainLabel.backgroundColor = UIColor.yellow
    }
    // 😆 코드 분석
    // override 키워드가 있는것을 보면 상위 클래스의 메소드를 재정의 한 것을 알 수 있음
    // 즉 UIViewController에 정의 된 것을 재정의 한것임
    // 무조건 super.viewDidLoad() 상위 viewDidLoad를 호출하라고 공식 문서에 적혀있음
    

    // sender 파라미터 이름을 관습적으로 sender 라고함
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        //UILabel 타입에는 다양한 속성이 있는 것임
        mainLabel.text = "안녕하세요"
        //mainLabel.backgroundColor = UIColor.yellow
        mainLabel.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        // #colorLiteral 하면 저렇게 컬라 값 그대로 확인 가능함 가독성이 좋음 어떤 컬러인지 바로 알 수 있음
        // #imageLiteral 이렇게 하면 나중에 이미지 선택시 어떤 이미지가
        // 선택 되었는지 바로 알 수 있음
        
        mainLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        // 이런거 외우는건 아님 여담 NSTextAlignment.center 지금 이건 열거형임
        mainLabel.textAlignment = NSTextAlignment.right
        
        /*
         1.
         @IBOutlet, @IBAction 현재 이러한 어트리뷰트는
         컴파일러가 즉 컴퓨터가 알 수 있도록 정보를 알려주는 것임
         IB는 인터페이스 빌더 약자임
         Outlet은 배출구 우리가 코드로 작성한 어떠한 정보 설정을 스토리보드로 전달 하기 위한 키워드임
         코드 -> 스토리보드
         Action은 스토리보드에서 -> 코드 즉 스토리보드 상에서 이벤트가 일어나는 경우 어떤 함수를 호출하여 실행시킬 것인지 알려주는 키워드 (주석)임
         
         ---------------------------------------
         2.
         인터페이스빌드 즉 스토리보드는 여기처럼 작성되는 코드를 조금 더 쉽게 작성 되게 할 뿐임 내부에도 여기서 작성한 코드처럼 이루어져 있음
         이것을 보기 쉽게 만들어 놓은 것 뿐임
         
         -----------------------------------------
         3.코드지울 때 주의할점 !!!!!!!!!!!!!!
         
         1.
         @IBOutlet weak var mainLabel: UILabel! 이러한 것을 그냥 지우면 안됨
         스토리 보드 연결을 끊고 나서 코드 또한 지워줘야함 1. 스토리보드에서 마우스 우클릭해서 연결 상태를 확인하고 지울 항목을 x를 눌러서 연결 해제
         그다음 코드에서 지우기 : 코드에서만 지우면 스토리보드에는 남아있음
         
         2. 스토리보드에서 선택후 커넥션스 인스펙터 들어가서 연결 해제
         그다음 코드에서 삭제
         */
        myButton.backgroundColor = UIColor.yellow
        //이렇게 버튼은 액션 처리를 하기도 하지만 버튼 자체 색상이라던지 속성도
        // 변경 필요할때가 있음 그럴때 아울렛으로 주면 백그라운드 컬러 다 변경 가능
        myButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        // 글자 색상 변경 하는 건 현제 함수로 작동중이며 안에 파리미터들은 열거형임
        
    }
    
    // 😆 코드 분석
    // 클래스는 대문자로 시작 함수는 소문자로 시작 주의하자 꼭! 이런거 실수하면 기본기 없는 개발자로 봄
    // @IBAction func buttonPressed(_ sender: UIButton) {
    // (_ sender: UIButton) 즉 이 함수를 실행 시킬때 버튼이 들어온다 라고 생각하면됨
    // 즉 이 함수를 실행시키는 메개체가 넘어온다고 생각하자. 관습적으로 그런 놈들을 sender라고함
    /* 우리가 하나 생각해야하는게
     ViewController는 UIViewController를 상속받아 사용했기 때문에
     여러가지 변수와, 메서드들이 숨어있다라고 생각해야함 공식 문서에서 UIViewController 검색해보면
     어떠한것이 정의 되어 있는지 알 수 있음
     var view: UIView 이런거 내가 직접 선언할 수 없음 상위에서 이미 있기에 사용만 하면 됨
     
     */
    
}

