//
//  DetailView.swift
//  MemberList
//
//  Created by 정정욱 on 2023/05/03.
//

import UIKit

class DetailView: UIView {

    //MARK: - 멤버 저장속성 구현
    // 멤버 데이터가 바뀌면 ===> didSet(속성감시자) 실행
    // 속성감시자도 (저장 속성을 관찰하는) 어쨌든 자체는 메서드임
    var member: Member? {
        didSet {
            guard var member = member else {
                // 멤버가 없으면 (즉, 새로운 멤버를 추가할때의 상황)
                // 멤버가 없으면 버튼을 "SAVE"라고 셋팅
                saveButton.setTitle("SAVE", for: .normal)
                // 멤버가 없으면, 타입 저장 속성의 현재 숫자 가져오기
                memberIdTextField.text = "\(Member.memberNumbers)"
                return
            }
            // 멤버가 있으면
            mainImageView.image = member.memberImage
            memberIdTextField.text = "\(member.memberId)"
            nameTextField.text = member.name
            phoneNumberTextField.text = member.phone
            addressTextField.text = member.address
            
            // 나이항목 (옵셔널 정수형)
            guard let age = member.age else {
                // 나이 항목이 없으면 빈문자열로 표시
                ageTextField.text = ""
                return
            }
            // 나이 항목이 있으면 정수 ==> 문자열 변환 표기
            ageTextField.text = "\(age)"
            
            // 나이항목의 구현
            //ageTextField.text = member.age != nil ? "\(member.age!)" : ""
        }
    }
    
    //MARK: - UI구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 정렬을 깔끔하게 하기 위한 컨테이너뷰
    lazy var imageContainView: UIView = {
        let view = UIView()
        view.addSubview(mainImageView)
        //view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let memberIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "멤버번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberIdTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberIdStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [memberIdLabel, memberIdTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "이       름:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var nameStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "나       이:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var ageStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [ageLabel, ageTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "전화번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var phoneNumberStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "주       소:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var addressStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitle("UPDATE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame.size.height = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [imageContainView, memberIdStackView, nameStackView, ageStackView, phoneNumberStackView, addressStackView, saveButton])
        stview.spacing = 10
        stview.axis = .vertical
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    // ⭐️ 레이블 넓이 저장을 위한 속성 상수에다 하나 값을 설정한다음
    let labelWidth: CGFloat = 70 // 수정시 용이하게 사용
    // 애니메이션을 위한 속성 선언
    var stackViewTopConstraint: NSLayoutConstraint!
    
    //MARK: - 생성자 셋팅
    
    // 뷰를 만들기 위한 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupStackView()
        setupNotification()
        setupMemberIdTextField()  // 텍스트 필드 프로토콜 사용시 해당 대리자 설정 필요
    }
    
    required init?(coder: NSCoder) {// 뷰를 만들기 위한 생성자 구현시 필수 생성자 구현 필요
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        self.addSubview(stackView)
    }
    
    //MARK: - 노티피케이션 셋팅
    
    func setupNotification() {
        // 노티피케이션의 등록 ⭐️
        // (OS차원에서 어떤 노티피케이션이 발생하는지 이미 정해져 있음)
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        
     
    // 관찰을 할 객체가 누군이지 설정을 해줌(관찰자를 등록) 현제 이 객체 self로 설정
    // 쉽게 키보드가 올라오면 해당 함수를 실행 시키겠다라는 것임
        /*
        이처럼 다양한 알림들을 애플이 지원을 해줌
         UIResponder.keyboardDidShowNotification
         . 다음 확인 해보면 다양한 알림들을 애플에서 미리 다 만들었음
         화면 가로로 돌린다던지 등등
         */
        
        // 키보드가 내려갈때
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 텍스트 필드 프로토콜 사용시 대리자 설정 필요
    func setupMemberIdTextField() {
        memberIdTextField.delegate = self
    }
    
    //MARK: - 오토레이아웃 셋팅
    
    // 오토레이아웃 업데이트
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageContainView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            memberIdLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            ageLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            addressLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ])
        
        stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            stackViewTopConstraint,
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    //MARK: - 키보드가 나타날때와 내려갈때의 애니메이션 셋팅
    // 스택뷰안에 다 담겨있기 때문에 스택뷰가 살짝 올라가고 내려가게 만들면 됨
    // 키보드가 올라오고 내려갈때 실행될 메서드들을 구현
    @objc func moveUpAction() {
        stackViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        stackViewTopConstraint.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // 화면 터치하면 키보드 내려가게 하기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    //MARK: - 소멸자 구현
    // 옵저버 객체 관찰 객체를 없에기 위해 디테일 뷰 객체가 사라질때 실행되는 소멸자를 실행
    deinit {
        // 노티피케이션의 등록 해제 (해제안하면 계속 등록될 수 있음) ⭐️
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
     
    }
}

// ⭐️ 멤버 아이디를 변경 하는 순간 앱이 꺼져버림 그걸 방지하기 위해
// UITextFieldDelegate를 채택하고
// 멤버 아이디 변경 못하게 만들어줌
//MARK: - 텍스트필드 델리게이트 구현

extension DetailView: UITextFieldDelegate {
    
    // shouldChangeCharactersIn 메서드는 텍스트 필드에서 입력 될때마다 실행 될것임
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 멤버 아이디는 수정 못하도록 설정 (멤버아이디의 텍스트필드는 입력 안되도록 설정)
        if textField == memberIdTextField {
            return false // 지금 현제 입력되고 있는 텍스트 필드가 memberIdTextField면 수정 못하게 해줌
        }
        
        // 나머지 텍스트필드는 관계없이 설정 가능
        return true
    }
}
