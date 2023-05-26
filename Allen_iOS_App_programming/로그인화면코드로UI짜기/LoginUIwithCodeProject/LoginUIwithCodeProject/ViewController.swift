//
//  ViewController.swift
//  LoginUIwithCodeProject
//
//  Created by 정정욱 on 2023/03/15.
//

import UIKit

//⭐️ 클래스는 동적 디스패치 때문에 느린데 실무에서는 뷰컨 앞에 final 키워드를 붙여 상속이 불가능하게 함으로써
// 다이렉트 디패치를 사용하게 만들어 버림 꼭 붙이자
final class ViewController: UIViewController {

    // MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = { // ⭐️ private 접근제어 같은 클래스 내부에서 만 사용하게 실무적 관점에서 final과 마찮가지로 붙이는게 좋음
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField) // 뷰 위에다 텍스트 필드와
        view.addSubview(emailInfoLabel) // 레이블을 올리는 것임
        // 가장 마지막 코드 순서대로 맨 마지막에 올라옴
        return view
    }()
    // 😀 뷰에 바로 올리기 위해 lazy var 로 선언
    //  클로저 실행문 안에는 어짜피 변수에 넣기 위함임으로 간단하게 이름 지음
    
    // "이메일 또는 전화번호" 안내문구
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        //값이 변할때마다 셀렉터를 통해서 해당 함수를 호출
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
 
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        //view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        // ⭐️  lazy var 해야 addSubview를 여기에 넣을 수 있음 순서가 있어야 되기 때문임
        // lazy var는 뷰컨트롤러를 먼저 메모리에 먼저 올린 후에, 해당 뷰 컨트롤러의 인스턴스에 접근할 필요가 있는.. 예를 들어 self.view.addSubview(버튼) 와 같은 코드가 있을때 사용하시면 됩니다.
        view.addSubview(passwordTextField) // passwordTextField 이런게 먼저 올라가 있어야함
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 패스워드텍스트필드의 안내문구
    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true // 비번이라 가리는 설정
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    
    // 따로 표시하는 게 없기 때문에 직접 구현
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - 로그인버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1 // 보더의 넓이 설정
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) // 보더 컬러 설정
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false    // 처음에 버튼 실행 안되게 설정 나중에 이메일 입력하면 누를수 있게 바꿀것임
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        /*
         ⭐️ 스택뷰 기본 생성자로 생성하고 stackView.addSubview(emailTextFieldView)
         이런식으로 추가해서 넣어줄수도 있음
         */
        stview.spacing = 18 // 내부간격
        stview.axis = .vertical // 세로 축으로 설정
        stview.distribution = .fillEqually  // 분배는 동등하게 체운다
        stview.alignment = .fill    // 정렬은 완전 체워서 정렬
        // 이런거 다 스토리보드로 만들떄 설정해주는 것이였음
        return stview
    }()
    
    
    // 비밀번호 재설정 버튼
    private lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
      
        // 버튼 누르면 alert창 뜨게 만들기
        // addTarget 은 #selector를 사용해서 다른 함수를 연결 하는 것임
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48 // ⭐️ 이런식으로 오토레이아웃 잡을때 기준 값을 만들면 나중에 아래에서 하나하나 값 잡은거 한방에 수정 가능
    // ⭐️ 즉 아래 오토레아웃 코드에 모두 영향을 미침
    
    
    // ⭐️ 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    // y축 즉 가운데 제약을 담아둔것임
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    // MARK: - 뷰디드로드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //⭐️ 이렇게 해야지만 두 텍스트필드의 대리자가 뷰컨이 되는 것임
        // 이렇게 대리자 역할을 뷰컨이해야지만 아래 확장에서 정의한 메서드들을 사용할수 있는 것임
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        setupAutoLayout()
        
    }
    

    
    // 오토레이아웃
    private func setupAutoLayout() {
        view.backgroundColor = UIColor.black
        view.addSubview(stackView)// 설정이 끝난 스택뷰를 올려줌
        view.addSubview(passwordResetButton)
        
        // 자동으로 잡아주는거 해제
        
        
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        // ⭐️ 이 안에 넣어주면
        //emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8).isActive = true
        // 이런식으로 .isActive = true 끝에 다 활성화 붙일 필요 없음
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
           // 앞뒤 8 간격을 가운데 기준으로 맞춤 뷰를 기준 가운데 맞춘거라 탑, 바텀 따로 설정 필요 없음 // 지금 맞추는 기준은 맨 뒤에 있을 뷰를 기준으로 맞춘것임
           // emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
           // 이 레이블이 동적으로 움직이게 만들어야 해서 정적으로 이렇게 두면 안되는것임
            emailInfoLabelCenterYConstraint, // 위에서 만든 변수로 선언
            
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            
            // 페스워드 관련 오토레이아웃
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            //passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            passwordInfoLabelCenterYConstraint, // 위와 똑같이 동적으로 만들기 위해 변수 사용
            
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
           
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            // 표시가 끝에 붙어있어서 끝에만 맞춰줌
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
            
            // 스택뷰 오토레이아웃 잡아주기
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            
            // 비밀번호 재설정 버튼 오토레이아웃
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight),
            
        ])
        
        
    }
  
    // MARK: - 비밀번호 가리기 모드 켜고 끄기
    @objc func resetButtonTapped(){
       // print("resetButton이 눌렸습니다.")
        
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)// .actionSheet 버튼이 아래서 위로 올라옴
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        
        // 액션을 올려줘야함
        alert.addAction(success)    // view 와 비슷한 객체라고 생각하면 됨 .addSubview 와 같이 올려주는 것임
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil) // present는 다음화면으로 넘어가게 해주는 메서드임 실제로 우리가 보는 이 alert 창도 다음 화면임
        // 사이드 눌러보면 동작하지 않음
    }
  
    @objc func passwordSecureModeSetting(){
        passwordTextField.isSecureTextEntry.toggle()  //false 비밀번호를 가리지 않음, true 비밀번호를 가림 어렵게 if문 처리할 필요없음
        //toggle() 메서드 사용시 한번 누르면 참 한번 누르면 거짓 반복임
    }
    
    
    @objc func loginButtonTapped(){
        print("로그인 버튼이 눌렸습니다.")
    }
    
    // 앱의 화면을 터치하면 동작하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 지금 첫번째 응답 객체들을 종료시켜서 다 내려감 (키보드가 내려갈 것임)
    }
    
}



// 텍스트필드 사용하기위해서 프로토콜을 채택해야하는데 일반적으로 아래와 같이 확장을해서 구현함 : 일반적인 델리게이트 패턴 사용방법
extension ViewController: UITextFieldDelegate { // 코드가 좀더 정리되기 때문임 아래와 같은 메서드들이 위에 뷰컨에 한번에 있으면 정신 없음
    
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    // ⭐️ 아래 선택적 요구사항 메서드를 구현하여 텍스트 필드가 시작 되는 시점, 끝나는 시점을 케치하여 레이블 오토레이아웃을 조정
    
    // 애니메이션을 텍스트필드 시작할때와 끝날때 주면 되니까 아래와 같은메서드를 구현함
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {    // 유저가 선택한게 emailTextField라면 백그라운드 색상을 바꾸고, 폰트 크기를 바꿈
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13 // -13 만큼 높이가 올라가는 것임
        }
        
        if textField == passwordTextField { // 유저가 선택한게 passwordTextField라면
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded() // 하위에 있는 모든걸 자연 스럽게 이동 시키는 코드
//            self.emailTextFieldView.layoutIfNeeded()
//            self.passwordTextField.layoutIfNeeded() // 이렇게 따로 따로 두개 쓰는게 귀찮아서 이렇게 사용한 것임
        }
    }
    
    // 택스트 필드 끝나면 원래대로 되돌리기 위와 반대되는 코드 삽입
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" { // 입력된게 없으면 다시 되돌리기
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) { // 이코드가 없으면 애니메이션이 따로 없어서 조금 딱딱하게 보여짐 그래서 애니메이션 효과 주기위한 코드
            self.stackView.layoutIfNeeded() // 0.3 초동안 애니메이션 효과가 일어남 : 오토레이아웃 동적 조정할때는 이런 애니메이션 코드를 꼭 삽입함
        }
    }
    
    // MARK: - 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
    // 매개변수로 텍스트 필드가 전달 될것임
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " { // 텍스트 필드가 한게인데 공백문자면
                textField.text = "" // 빈 문자열로 만들고 해당 함수 빠져나감
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty, // 텍스트가 있고, 비어있지 않다면 (! 붙여서 부정으로 아니라면)
            let password = passwordTextField.text, !password.isEmpty // 텍스트가 있고 비어있지 않다면
        else {
            loginButton.backgroundColor = .clear    // 조건에 맞지않다면 원래대로 클리어 색상에 버튼 활성화 시키지 않음
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red // 색상을 바꾸고
        loginButton.isEnabled = true    // 버튼을 활성화 시킴
    }
    //⭐️ 현제 글자가 하나하나 입력 될때마다 이 함수를 실행 시키는 것임
}
