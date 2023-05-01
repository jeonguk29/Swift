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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        setupTableViewConstraints()
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

