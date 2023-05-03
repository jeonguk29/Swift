//
//  DetailViewController.swift
//  MemberList
//
//  Created by 정정욱 on 2023/05/03.
//

import UIKit

// 다음 화면을 위한 뷰 컨트롤러
final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    var member: Member? // 멤버를 전화면에서 전달 받아야함
    
    
    override func loadView() {
        view = detailView // viewDidLoad 보다 먼저 호출 되는 부분에서 뷰를 교체
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonAction()
        setupData()
      
    }
    
    private func setupData(){
        detailView.member = member
    }
    
    // 뷰에 있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    // 이 버튼이 눌리면 동작을 self 이 컨트롤러에서 실행 되어야함
    
    
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
            
            // 1) 델리게이트 방식이 아닌 구현⭐️
            let index = navigationController!.viewControllers.count - 2
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! ViewController
            // 전 화면의 모델에 접근해서 멤버를 추가
            vc.memberListManager.makeNewMember(newMember)
            
            
            // 2) 델리게이트 방식으로 구현⭐️
            //delegate?.addNewMember(newMember)
            
            
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
            // 1) 델리게이트 방식이 아닌 구현⭐️
            let index = navigationController!.viewControllers.count - 2 // 2가 들어있을 것임 뷰컨이랑, 디테일 뷰컨  그래서 현제 뷰컨에 접근 하기 위해 0으로 만들어줌
            
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! ViewController
            // 전 화면의 모델에 접근해서 멤버를 업데이트
            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            // 몇번째 인덱스를 업데이트 해야할지 상수에 담을값으로 넣어줌, 멤버도 전달
            
            // 델리게이트 방식으로 구현⭐️
            //delegate?.update(index: memberId, member!)
        }
        
        // (일처리를 다한 후에) 전화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
}
