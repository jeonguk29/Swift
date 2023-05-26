//
//  DetailViewController.swift
//  MemberList
//
//  Created by 정정욱 on 2023/05/03.
//

import UIKit
import PhotosUI

// 다음 화면을 위한 뷰 컨트롤러
final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    //⭐️ 커스텀 델리게이트 3단계
    weak var delegate: MemberDelegate? // MemberDelegate를 채택한 타입이 대리자가 될수 있음
    //2단계에서 ViewController 확장으로 MemberDelegate를 채택했음
    //⭐️ 커스텀 델리게이트 6단계 weak 키워드를 붙여 약한참조 

    var member: Member? // 멤버를 전화면에서 전달 받아야함
    
    
    override func loadView() {
        view = detailView // viewDidLoad 보다 먼저 호출 되는 부분에서 뷰를 교체
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAction()
        setupData()
        setupTapGestures()
      
    }
    
    private func setupData(){
        detailView.member = member
    }
    
    // 뷰에 있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    // 이 버튼이 눌리면 동작을 self 이 컨트롤러에서 실행 되어야함
    
    
    //MARK: - 이미지뷰가 눌렸을때의 동작 설정
    
    // 제스쳐 설정 (이미지뷰가 눌리면, 실행): 터치 동작 같은게 안되는 이미지 뷰 같은거에 터치동작 가능하게
    func setupTapGestures() {
        // 타겟 설정 어떤 함수 넣을 건지
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        // 이미지 뷰에 제스쳐 올리기
        detailView.mainImageView.addGestureRecognizer(tapGesture)
        // 이미지 뷰에 유져의 이벤트에 따라 동작이 가능 하게 변경 기본은 false로 되어 있음
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        print("이미지뷰 터치")
        setupImagePicker() // 피커뷰를 띄우게 만듬
    }
    
    // 아래 코드만 위에 메서드에 다 넣어 버려도 문제 없음
    func setupImagePicker() {
        // 기본설정 셋팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        // 0 설정시 사진을 무한대로 가져올수 있음 1 설정시 1개 2설정시 2개
        configuration.filter = .any(of: [.images, .videos]) // 사진, 동영상도 선택 할 수 있게
        
        // 기본설정을 가지고, 피커뷰컨트롤러 생성
        let picker = PHPickerViewController(configuration: configuration)
        // 피커뷰 컨트롤러의 대리자 설정
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
    
    // 유저에 대한 정보 업데이트, 이전 화면으로 돌아가기
    @objc func saveButtonTapped(){
        // [1] 멤버가 없다면 (새로운 멤버를 추가하는 화면)
        if member == nil {
            // 입력이 안되어 있다면.. (일반적으로) 빈문자열로 저장
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            let phoneNumber = detailView.phoneNumberTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            // 새로운 멤버 (구조체) 생성
            var newMember =
            Member(name: name, age: age, phone: phoneNumber, address: address)
            newMember.memberImage = detailView.mainImageView.image
            
//            // 1) 델리게이트 방식이 아닌 구현⭐️
//            let index = navigationController!.viewControllers.count - 2
//            // 전 화면에 접근하기 위함
//            let vc = navigationController?.viewControllers[index] as! ViewController
//            // 전 화면의 모델에 접근해서 멤버를 추가
//            vc.memberListManager.makeNewMember(newMember)
//            
            
            // 2) 델리게이트 방식으로 구현⭐️
            //⭐️ 커스텀 델리게이트 8단계
            delegate?.addNewMember(newMember)
            
            
        // [2] 멤버가 있다면 (멤버의 내용을 업데이트 하기 위한 설정)
        } else {
            // 이미지뷰에 있는 것을 그대로 다시 멤버에 저장
            member!.memberImage = detailView.mainImageView.image
            
            // 텍스트 필드에 있는 내용들을 그대로 넣어줌
            let memberId = Int(detailView.memberIdTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "") ?? 0
            member!.phone = detailView.phoneNumberTextField.text ?? ""
            member!.address = detailView.addressTextField.text ?? ""
            
            // 뷰에도 바뀐 멤버를 전달 (뷰컨트롤러 ==> 뷰)
            detailView.member = member
            /*
             ⭐️⭐️⭐️ 네비게이션 컨트롤러는 화면위에 push 화면위에 push 스택 구조임
             그렇기 때문에 이전화면에 대한 정보도 가지고 있을것임
             navigationController는 viewControllers 라는 속성에
             viewController들이 배열로 관리가 됨
             */
//            // 1) 델리게이트 방식이 아닌 구현⭐️
//            let index = navigationController!.viewControllers.count - 2 // 2가 들어있을 것임 뷰컨이랑, 디테일 뷰컨  그래서 현제 뷰컨에 접근 하기 위해 0으로 만들어줌
//
//            // 전 화면에 접근하기 위함
//            let vc = navigationController?.viewControllers[index] as! ViewController
//            // 전 화면의 모델에 접근해서 멤버를 업데이트
//            vc.memberListManager.updateMemberInfo(index: memberId, member!)
//            // 몇번째 인덱스를 업데이트 해야할지 상수에 담을값으로 넣어줌, 멤버도 전달
//
     
            
            /*
             커스텀 델리게이트를 사용해야 하는 이유
             기존에 유저의 정보를 업데이트 하면 어떤 화면으로 갔다가 다시 돌아올때
             override func viewWillAppear(_ animated: Bool) {
             해당 메서드를 사용하여 업데이트를 함
             이문제의 단점은 정보를 업데이트 하지 않고 회면을 뒤로 돌아가면 화면을 리프레쉬 한다는 단점이 있음
             이것을 해결하고자 커스텀 델리게이트를 사용할 것임
             */

            
            // 2)델리게이트 방식으로 구현⭐️
            //⭐️ 커스텀 델리게이트 8단계
            delegate?.update(index: memberId, member!)
            // 데리자한테 업데이트를 해 이런 방식으로 구현하려고 하는 것임
            
        }
        
        // (일처리를 다한 후에) 전화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
}

// 이 프로토콜을 채택하면 사진첩에 접근해서 델리게이트 패턴으로 전달 받을 수 있음
extension DetailViewController: PHPickerViewControllerDelegate{
    // 사진이 선택이 된 후에 호출되는 메서드
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 피커뷰 dismiss
        picker.dismiss(animated: true) // 다시 전화면으로 이동
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    // 이미지뷰에 표시
                    self.detailView.mainImageView.image = image as? UIImage
                    // 이 메서드 자체가 비동기 적으로 일어나는 메서드 이기 때문에 메인큐에 다시 넣고 있음 
                }
            }
        } else {
            print("이미지 못 불러왔음!!!!")
        }
    }
    
}
