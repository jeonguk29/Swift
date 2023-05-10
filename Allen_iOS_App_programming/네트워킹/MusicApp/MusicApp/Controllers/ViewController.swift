//
//  ViewController.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import UIKit

final class ViewController: UIViewController {

    // 🍏 서치 컨트롤러 생성 ===> 네비게이션 아이템에 할당
    let searchController = UISearchController()
    
    // 🍎 서치 Results컨트롤러 ⭐️
    //let sear = UISearchController(searchResultsController: <#T##UIViewController?#>)
    
//    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    // 테이블 뷰 연결
    @IBOutlet weak var musicTableView: UITableView!
    
    // 네트워크 매니저 (싱글톤)
    var networkManager = NetworkManager.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    // 서치바 셋팅
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        
        // 🍏 1) (단순)서치바의 사용
        searchController.searchBar.delegate = self
        // 서치바 사용 테이블뷰 사용과똑같이 델리게이트 설정 필요함
        
//        // 🍎 2) 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
//        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
//        searchController.searchResultsUpdater = self

        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    // 테이블뷰 셋팅
    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        // Nib파일을 사용한다면 등록의 과정이 필요
       // musicTableView.register(<#T##AnyClass?#>, forCellReuseIdentifier: <#T##String#>) 일반적으로 코드로 구현할때는 이 명령어를 사용했음 하지만 NIB으로 만들었기 때문에 등록해서 사용해야함
        //셀을 직접적으로 테이블 뷰에 올라면 셀등록코드가 자동으로 들어가있는 것임 NIB파일로 따로 만들어서 등록 필요
        
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
        // nibName에 nib파일 이름 넣어주면 됨 Name Space로 만들어서 넣어준 것임
        // bundle은 폴더 이름을 이야기 하는데 라이브러리에서 끓어다 쓸때 사용함 
        
        //musicTableView.rowHeight = 120
    }
    
    // 데이터 셋업
    func setupDatas() {
        // 네트워킹의 시작
        
        // 검색하고 싶은 단어 입력 앱 실행하자마자 제즈 검색 단어 나오게 만듬 없으면 밋밋해서
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            // 실행 시 result 타입 넘어옴
            // Result<[Music], NetworkError> 이런 타입이 넘어옴
            // 열거형이 넘어와서 switch-case문 사용함
            print(#function)
            switch result {
            case .success(let musicDatas): //열거형에서 연관 값 벗겨내기
                // 데이터(배열)을 받아오고 난 후
                self.musicArrays = musicDatas // 클로저 내부에 캡처현상 발생 할 수 있어서 self키워드 사용
                // 테이블뷰 리로드
                DispatchQueue.main.async { // 테이블 뷰 다시 그리기 위해 메인쓰레드에서 리로드
                    self.musicTableView.reloadData() // 네트워킹 코드자체가 비동기 코드라 그럼
                }
                // 테이블을 리로드 하는 코드는 네트워킹 끝난후 콜백 함수 쪽에 작성해야함  
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// 테이블 뷰 프로토콜 채택후 필수 메서드 구현
extension ViewController: UITableViewDataSource {
    
    // 테이블 뷰 셀을 몇개를 그릴건지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return self.musicArrays.count
    }
    
    // 테이브 뷰 셀을 어떻게 그릴건지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        /* ⭐️⭐️ 
         dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier
         여기를 기존에는 "MusicCell" 이렇게 문자열로 사용했었는데 문자열로 이렇게 사용하는건 실수를 많이 할 수 있음
         일반적으로 실무에서 Helpers 폴더에 Name Space 만들어 사용을 하는 방식을 많이 사용
         */

        
        cell.imageUrl = musicArrays[indexPath.row].imageUrl
        
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
        
        cell.selectionStyle = .none
        return cell
    }
}

/*
 테이블 뷰 만들때 UITableViewDataSource 채택시 필수 구현메서드가 있지만
 UITableViewDelegate 채택시 선택적으로 구현할 메서드들이 많이 있음
 */
extension ViewController: UITableViewDelegate {
   // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 방법은 4가지임 직접 테이블 속성으로 구현 하던가 아래와 같은 방법으로 프로토콜 채택하여 구현 하던가
    // (musicTableView.rowHeight = 120 대신에 사용가능)
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // 셀의 높이를 조건문을 줘서 어떤 경우에는 130 리턴 어떤 경우는 140 리턴 이렇게 유동적으로 변경 가능하지만
//        // 직접 변경시 이런 작업이 어려움
//        return 120
//    }
    
    // 셀을 너가 알아서 높이 잡으라는 명령어 오토레아아웃 잡았으면 알아서 보고 셀의 높이를 만들겠다는 뜻 임
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // 타입 저장 속성으로
    }
    
 
}


//MARK: - 🍏 (단순) 서치바 확장

// 필수 메서드가 아니라 선택적 메서드들이 많이 있음
extension ViewController: UISearchBarDelegate {

//    // 유저가 글자를 입력하는 순간마다 호출되는 메서드
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        print(searchText) // 서치바에서 글자 입력할때마다 전달 되서 출력 되는 것임
//        // 다시 빈 배열로 만들기 ⭐️
//        self.musicArrays = [] // 글자 입력마다 새로 테이블을 그려야 하기 때문임
//
//        // 네트워킹 시작
//        networkManager.fetchMusic(searchTerm: searchText) { result in
//            switch result {
//            case .success(let musicDatas):
//                self.musicArrays = musicDatas // 배열을 다시 만들고
//                DispatchQueue.main.async {
//                    self.musicTableView.reloadData() // 테이블을 리로드
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

    // 검색(Search) 버튼을 눌렀을때 호출되는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
        // 다시 빈 배열로 만들기 ⭐️
        self.musicArrays = []

        // 네트워킹 시작
        networkManager.fetchMusic(searchTerm: text) { result in
            switch result {
            case .success(let musicDatas):
                self.musicArrays = musicDatas
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.view.endEditing(true)
    }
}


//MARK: -  🍎 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능

extension ViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
