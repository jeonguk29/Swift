//
//  ViewController.swift
//  MemberList
//
//  Created by 정정욱 on 2023/05/01.
//

import UIKit

final class ViewController: UIViewController {
    // 현제 클래스를 다른 곳에서 상속하지 않을 거기 때문에 final 키워드를 사용 속도 UP 코드 영역에서 직접 주소를 삽입 해버림
    
    // 테이블 뷰 생성
    private let tableView = UITableView()
    
    // MVC로 만들었으니까 비즈니스 로직에 접근 할수 있는 객체 생성
    var memberListManager = MemberListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDatas()
        setupNaviBar()
        setupTableView()
        setupTableViewConstraints()
        
    }
    
    func setupNaviBar() {
        title = "회원 목록"
        
        // 네비게이션바 설정관련
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션바 오른쪽 상단 버튼 설정
        //self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = 60 // 셀의 크기 설정 
    }
    
    func setupDatas(){
        memberListManager.makeMembersListDatas() // 빈 배열을 만들지 않기위해 미리 한번 만들어주기
        // 일반적으로는 서버에 요청
    }
    
    
    // 테이블 뷰의 오토 레이아웃 설정
    func setupTableViewConstraints(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
        // 배열 개수로 몇개의 셀을 만들지 정의
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

