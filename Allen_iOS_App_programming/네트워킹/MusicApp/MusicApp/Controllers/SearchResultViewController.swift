//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import UIKit

final class SearchResultViewController: UIViewController {

    // 컬렉션뷰 (테이블뷰와 유사)
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 컬렉션뷰의 레이아웃을 담당하는 객체 ⭐️
    // - 컬렉션 뷰의 형태 모든 레이아웃을 담당하는 객체임
    let flowLayout = UICollectionViewFlowLayout()
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManager.shared
    
    // (음악 데이터를 다루기 위함) 빈배열로 시작
    var musicArrays: [Music] = []
    
    // (서치바에서) 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    // - 단어 전달 받으면 속성 감시자가 반응을 함 
    var searchTerm: String? {
        didSet {
            setupDatas() // 단어 전달 받을때 마다 네트워킹 작업으로 검색함
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        view.backgroundColor = .white
        setupCollectionView()
        //setupDatas()
    }

    func setupCollectionView() {
        // 컬렉션뷰의 레이아웃을 담당하는 객체
        //let flowLayout = UICollectionViewFlowLayout()
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        // 컬렉션뷰의 스크롤 방향 설정
        // - 컬렉션뷰는 세로, 가로 다 스크롤이 가능 하기 때문에 세로로 수직으로 스크롤하게 만든 것임
        flowLayout.scrollDirection = .vertical
        
        // Name Space 를 사용하여 지정 했음 기획자, 디자이너가 간격 수정해달라고 할때 번거로움을 방지하기 위함
        
        // UIScreen.main.bounds.width 는 아이폰 스크린 너비 : 현제 5개의 컬렉션 뷰 보여줄때
        // 4개의 선 필요함 4개의 컬랙션 뷰면 3개의 선 필요하고 그걸 그려주기 위한 코드임
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        // 아이템 사이즈 크기 설정
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWitdh
        
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWitdh
        
        // 컬렉션뷰의 속성에 할당 ⭐️ 이렇게 할당 해주는게 핵심임
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    /*
     컬랙션 뷰에서 중요한 것은 UICollectionViewFlowLayout() 라는 레이아웃을 담당하는 객체가 따로 있다.
     이 객체를 가지고 설정을 해줘야지만 컬랙션 뷰를 우리가 원하는 형태로 주무를수 있음
     
     */
    
    // 데이터 셋업
    func setupDatas() {
        // 옵셔널 바인딩
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어 \(term)")
        
        // (네트워킹 시작전에) 다시 빈배열로 만들기
        self.musicArrays = []
        
        // 네트워킹 시작 (찾고자하는 단어를 가지고)
        networkManager.fetchMusic(searchTerm: term) { result in
            switch result {
            case .success(let musicDatas):
                // 결과를 배열에 담고
                self.musicArrays = musicDatas
                // 컬렉션뷰를 리로드 (메인쓰레드에서)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// 사용하기 위해 프로토콜 채택 컬렉션에서 로우는 아이템이라고 부름
extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        cell.imageUrl = musicArrays[indexPath.item].imageUrl
        
        return cell
    }
    
}
