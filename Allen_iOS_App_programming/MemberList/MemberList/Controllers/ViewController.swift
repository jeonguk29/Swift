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
        tableView.delegate = self
        
        tableView.rowHeight = 60 // 셀의 크기 설정

        // 코드로 셀 등록시 이걸 꼭 해줘야함
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
        // 타입 인스턴스 형태로 첫번째 매개변수를 넘겨 줘야함
        // 여기서 등록을 하니까 아래서 꺼내서 셀을 사용할 수 있는 것임 
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

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
        // 배열 개수로 몇개의 셀을 만들지 정의
    }
    
    // 셀을 그림
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath)
        as! MyTableViewCell
        
        /* 셀 구현 첫번째 방법
        cell.mainImageView.image = memberListManager[indexPath.row].memberImage
        // 서브스크립트로 구현해서 이와 같이 구현함 
        // memberListManager.getMembersList()[IndexPath.row]
        cell.memberNameLabel.text = memberListManager[indexPath.row].name
        cell.addressLabel.text = memberListManager[indexPath.row].address
        cell.selectionStyle = .none
        */
        
        // 2번째 방법
        /*
         MyTableViewCell 파일에서 아래와 같은 코드를 구현했기 때문에
         var member: Member? {
             didSet {
                 guard var member = member else { return }
                 mainImageView.image = member.memberImage
                 memberNameLabel.text = member.name
                 addressLabel.text = member.address
             }
         }
         */
        // 저장속성에 멤버를 저장하면 셀에서 알아서 꺼내서 이미지, 레이블 표시하고 할 수 있는 것임
        // 이방식이 좀더 고급스럽고 편한 방법임
        
        cell.member = memberListManager[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
}

// 셀 클릭시 DetailViewController로 이동 하기 위한 부분
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음화면으로 넘어가는 코드
        let detailVC = DetailViewController()
        
        let array = memberListManager.getMembersList()
        detailVC.member = array[indexPath.row]
        
        // 네비게이션 컨트롤러로 이동시킴
        navigationController?.pushViewController(detailVC, animated: true)
       
    }
 
}
