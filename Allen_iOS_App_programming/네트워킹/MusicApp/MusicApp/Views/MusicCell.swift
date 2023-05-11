//
//  MusicCell.swift
//  MusicApp
//
//  Created by Allen H on 2022/04/20.
//

import UIKit

final class MusicCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // 이미지 URL을 전달받는 속성
    // 저장속성이 병경되면 메서드 실행되도록 구현함
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    // 셀이 재사용되기 전에 호출되는 메서드
    // - 이름 그대로 재사용되기 위한 준비를 한다
    // - 기존에 보이는 이미지 뷰에 nil 처리를 해주지 않으면 셀이 재사용 될때 이전에 이미지를 계속 가지고 있을 수 있음
    // - 셀 재사용 되기전 호출이되는데 이메서드에서 아래와 같이 처리를 해주는 것임 
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.mainImageView.image = nil
    }

    
    // 스토리보드 또는 Nib으로 만들때, 사용하게 되는 생성자 코드
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // URL ===> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        // 현재 문자열과              서버에서 받아온 문자열을 옵셔널 바인딩 : 아래서 확인 하는 작업이 있기 때문
        
        
        //😍 원래는 이렇게 사용하는게 정석적인 구현임
    
//               // 2. URL 세션사용
//        guard let url = URL(string: urlString) else { return  }
//
//        let session = URLSession(configuration: .default)
//
//               // 3. 이미지 받아오기
//        let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//
//                    return
//                }
//
//                guard let safeData = data else {
//
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self.mainImageView.image = UIImage(data: safeData)
//                }
//
//            }
//            task.resume()
//
        
        //😍 또 다른 방법
        
        DispatchQueue.global().async {
            
            // Data(contentsOf: url) 이코드는 URLSession을 통해 데이터 까지 받아오는 생성자임 url을 가지고 데이터를 생성할 수 있는 코드
            // - 일반적으로 이미지 url을 가지고 데이터로 변형할때 많이 사용
            // - 내부가 동기적으로 처리 되어있음 비동기가 아닌 기다리기 때문에 오래걸림
            // 그래서 DispatchQueue를 통해 다른 쓰레드로 보내줘야함 (2번 쓰레드)
            // 데이터 생성 됬으면 DispatchQueue.main을 이용하여 다시 메인 스레드에서 이미지 표시작업을 진행
            
            guard let data = try? Data(contentsOf: url) else { return }
            
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            // 테이블 뷰를 빠르게 내릴때 이미지를 받아오는 동안에 셀이 재사용 되면서 잘못된 이미지를 표시하지 못하게 확인 하는 작업
            guard urlString == url.absoluteString else { return }
            // - 오래걸리는 일을 한 동안에도 문자열 비교후 url이 똑같은지 확인 똑같으면 다음 줄로 넘어감
            // 그래야 올바른 이미지 표시 가능
            // + url.absoluteString url이 URL 타입이라 문자열로 바꿔 주는 것
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    /*
     셀에서도 잘못된 일이 일어날수 있음 아무리 imageUrl를 받아 가지고 있다고 하더라도
     imageUrl 를 서버에 요청한다고 했을때 테이블 뷰 빠르게 스크롤 하면
     본질적으로 네트워크 작업이 오래걸리기 때문에 셀을 재사용하는 문제가 여전히 남아있음
     
     그래서 셀을 빠르게 내릴때 현재 imageUrl 이랑 서버에서 가져온 imageUrl를 비교해서 같은지 판단하는
     코드를 넣어줘야함 빠르게 셀이 내려가더라도 올바른 이미지 표시를 위해
     */
}
