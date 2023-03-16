//
//  ViewController.swift
//  LoginUIwithCodeProject
//
//  Created by 정정욱 on 2023/03/15.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
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
//        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
 
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        //view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
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
//        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
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
//        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
           // 앞뒤 8 간격을 가운데 기준으로 맞춤 뷰를 기준 가운데 맞춘거라 탑, 바텀 따로 설정 필요 없음 // 지금 맞추는 기준은 맨 뒤에 있을 뷰를 기준으로 맞춘것임
            
            
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            
            // 페스워드 관련 오토레이아웃
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
           
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
}

