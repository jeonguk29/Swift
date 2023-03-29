//
//  MovieCell.swift
//  TableView
//
//  Created by 정정욱 on 2023/03/29.
//

import UIKit

// 해당 뷰랑(객체) 코드를 연결하고 나서 어시스턴스를 통해 불러오고 싶은데 잘 되지 않는다면
// 1. 커맨드 + B 눌러서 빌드후 다시 켜보기, 2 Xcode 껏다켜기
// 3. 스토리보드에서 해당 객체를 선택후 직접 옵션키 + 해당 파일 선택하기

class MovieCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
