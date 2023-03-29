//
//  ViewController.swift
//  TableView
//
//  Created by 정정욱 on 2023/03/29.
//

import UIKit

// 테이블 뷰 사용시 공식 처럼 사용한다고 생각하기 UITableViewDataSource 프로토콜 채택
class ViewController: UIViewController, UITableViewDataSource {
   
    /*
     UITableViewDataSource 프로토콜은 ViewController와 통신을 하는 프로토콜인데
     테이블 뷰에 어떤 정보를 줄것인지에 대해 정보를 주는 것임
     즉 데이터 소스 나 컨텐츠는 몇개를 표시해야해? (셀을 몇개 표시해야해)
     그 셀을 어떻게 표시해야해? 등
    
     우선 채택을 하면 아래와 같은 메서드 2개를 구현해줘야함
     */
        
  
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // 똑같이 델리게이트 패턴을 사용하고 있어서 처리를 해줄 데리자를 지정해야하는데 이름이 조금 다른 것임 즉 테이블 뷰의 데리자 설정은 이런식으로 한다고 보면 됨
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 몇개의 컨텐츠를 만들면 되는지 알려주면 되는 메서드
        
        return 10 // 10개를 표시해라  행을 정해줌
    }
    
    
    // cellForRowAt 몇번째 행에 있는 셀은 어떤 방식으로 표현하면 됨?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

}

