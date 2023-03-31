//
//  ViewController.swift
//  TableView
//
//  Created by 정정욱 on 2023/03/29.
//

import UIKit

// 테이블 뷰 사용시 공식 처럼 사용한다고 생각하기 UITableViewDataSource 프로토콜 채택
class ViewController: UIViewController {
   

        
  //  var moviesArray: [Movie] = []
    var movieDataManager = DataManager()    //  ⭐️ 실제 데이터를 가지고 있는 놈
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // 똑같이 델리게이트 패턴을 사용하고 있어서 처리를 해줄 데리자를 지정해야하는데 이름이 조금 다른 것임 즉 테이블 뷰의 데리자 설정은 이런식으로 한다고 보면 됨
        
        tableView.rowHeight = 120 // 하나하나 셀의 높이를 설정함
        movieDataManager.makeMovieData() // ⭐️ 실제 데이터 생성 (서버와 통신한다고 가정)
       // moviesArray = movieDataManager.getMovieData() // ⭐️ 모델에서 구현한 것을 메니저로 만들어 요청 나 영화 데이터좀 줘!!
    }

}

// 일반적으로 프로토콜 채택해서 메서드를 구현할때 이렇게 확장에서 구현함 보기 편하기 때문
extension ViewController: UITableViewDataSource {
    
    
    /*
     UITableViewDataSource 프로토콜은 ViewController와 통신을 하는 프로토콜인데
     테이블 뷰에 어떤 정보를 줄것인지에 대해 정보를 주는 것임
     즉 데이터 소스 나 컨텐츠는 몇개를 표시해야해? (셀을 몇개 표시해야해)
     그 셀을 어떻게 표시해야해? 등
    
     우선 채택을 하면 아래와 같은 메서드 2개를 구현해줘야함
     */
    
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 몇개의 컨텐츠를 만들면 되는지 알려주면 되는 메서드
        
        
        return movieDataManager.getMovieData().count //⭐️ 나 배열좀 줘라 한다음 배열 반환되면 바로 카운트 적용
    }
    
    
    // cellForRowAt 몇번째 행에 있는 셀은 어떤 방식으로 표현하면 됨?
    // ⭐️ 즉 이 메서드는 테이블 뷰 셀을 그려 테이블 뷰에게 리턴해주는 메서드임
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell      // 우리가 스토리보드에 테이블뷰에 올린 테이블뷰 셀에 Identifier를 MovieCell로 지정하여 MovieCell라는 이름을 가진 셀을 꺼내 쓸거야라는 뜻임 계속 재사용 하겠다.
        // for: <#T##IndexPath#> 는 몇번째 셀에 있는 애를 꺼낼건지 경로를 넣으면 됨 보통 관습적으로 위에 파라미터로 들어오는 애를 사용함
        // dequeueReusableCell 메서드의 결과는 UITableViewCell이라는 일반적인 타입임 그걸 타입 케스팅 하여 사용해야함
        
        //우리가 실제로 UITableViewCell 를 상속받아 MovieCell 를 만들었고 그 속성들은 여기서 사용이 가능 한것임
        /*
         ⭐️indexPath 의 두가지 속성
         indexPath.section  :    테이블셀   (테이블 뷰를 그룹같은 것으로 만들었을때 그 그룹에 해당 하는 것임) : 그룹에 번호
         indexPath.row  :      테이블셀 행을 의미함  (몇번째 녀석인지)  : 그룹에 행 번호
         */
        
        // indexPath.row는 공식인데 우리가 만든 배열중 선택시 그 배열의 인덱스 번호가 들어간다고 생각하면 됨
        
        var array = movieDataManager.getMovieData() //⭐️ 배열 반환 될것임 그러면 바로 아래에서 사용
        
        let movie = array[indexPath.row]
        cell.mainImageView.image = movie.movieImage // 둘다 옵셔널 타입이라 바로 넣을 수 있음
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        cell.selectionStyle = .none     // 셀 선택시 배경색 바뀜 방지 가능
        
        return cell
    }
}
