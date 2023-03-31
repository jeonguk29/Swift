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
        // UITableViewDataSource 프로토콜 채택시 몇개의 행을 그리고 어떻게 그려야 할지 알려주는 대리자를 지정
        
        tableView.delegate = self // UITableViewDelegate 프로토콜 채택시 행동을 대리해줄 놈을 지정
        tableView.rowHeight = 120 // 하나하나 셀의 높이를 설정함
        
        title = "영화목록" // title 은 뷰컨이 가지고 있는 속성임
        
        movieDataManager.makeMovieData() // ⭐️ 실제 데이터 생성 (서버와 통신한다고 가정)
       // moviesArray = movieDataManager.getMovieData() // ⭐️ 모델에서 구현한 것을 메니저로 만들어 요청 나 영화 데이터좀 줘!!
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        movieDataManager.updateMovieData() // 영화 데이터 추가됨
        tableView.reloadData() // ⭐️⭐️ 반드시 뿌려질 데이터가 바뀔때 이 메서드 까지 입력해줘야 실제 테이블 뷰에 반영된게 보임
        // 이제 데이터가 바뀌었으니까 테이블 뷰 자체를 다시 불러와라
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
        
        print(#function)
        return movieDataManager.getMovieData().count //⭐️ 나 배열좀 줘라 한다음 배열 반환되면 바로 카운트 적용
    }
    
    
    // cellForRowAt 몇번째 행에 있는 셀은 어떤 방식으로 표현하면 됨?
    // ⭐️ 즉 이 메서드는 테이블 뷰 셀을 그려 테이블 뷰에게 리턴해주는 메서드임
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell      // 우리가 스토리보드에 테이블뷰에 올린 테이블뷰 셀에 Identifier를
        
        let array = movieDataManager.getMovieData() //⭐️ 배열 반환 될것임 그러면 바로 아래에서 사용
        
        let movie = array[indexPath.row]
        cell.mainImageView.image = movie.movieImage // 둘다 옵셔널 타입이라 바로 넣을 수 있음
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        cell.selectionStyle = .none     // 셀 선택시 배경색 바뀜 방지 가능
        
        return cell
        
        /*
         실제 힙에 올라가는 셀은 몇개 없음 드레그해서 나오는 부분 계속해서 힙에 추가 하는게 아님
         인간의 눈의 보이는 것만 6~7개 정도 힙에 올라가고 드레그를 통해 안보이는 경우 계속 힙에 유지 되는게 아니라 다음 드레그해서 나오는 셀에 그 힙 메모리를 할당 해주는 것임
         
         힙에 올라가 있는 셀(UITableViewCell)은 재사용됨
         장점: 최대한 힙에 이미 올라가 있는 메모리를 재사용 
         (내부 메커니즘을 이미 잘 설계. 우리는 사용하기만 하면 됨)
         
         ex 드레그해서 올라간 moviecell 껍데기만 남기고 컨텐츠를 버린다음 다시
         아래로 내려와 빈cell 껍데기에 무비 구조체를 체우는 방식인것임
         */
    }
}


// UITableViewDelegate 는 실제 테이블 뷰에서 일어나는 이벤트(행동 처리를 담당하는 프로토콜임) 델리게이트 패턴
extension ViewController: UITableViewDelegate{
    
    // cell이 하나 선택 되었을때 작동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // indexPath 그게 몇번째 행인지는 알아서 전달 해줄 것임
        performSegue(withIdentifier: "toDetail", sender: indexPath) //⭐️ 세그웨이로 이동 될때 해당 indexPath 값 까지 같이 전달을 하는 것임
    }
    
    // 세그웨이로 데이터 전달시 사용했었음
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // ⭐️ 그렇다면 prepare 메서드 구현시 sender에 indexPath 를 전달 받을 수 있음
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            
            let array = movieDataManager.getMovieData()
            
            let indexPath = sender as! IndexPath
            // 우리가 전달하기 원하는 데이터를 뽑아서 전달
            detailVC.movieData = array[indexPath.row] // row 까지 줌으로 정확한 행 전달 가능
            
            
        }
    }
}
