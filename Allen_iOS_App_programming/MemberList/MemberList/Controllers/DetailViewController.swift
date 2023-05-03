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
    
    @objc func saveButtonTapped(){
        print("버튼이 눌림")
    }



}
