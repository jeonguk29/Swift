//
//  Part2CollectionViewCell.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/07.
//

import UIKit

class Part2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avaterQuestionImage: UIImageView!
    
    @IBOutlet weak var avaterQuestionLabel: UILabel!
    
    func setup(with question: AvatarQuestion){
        avaterQuestionImage.image = question.avatarQuestionImage
        avaterQuestionLabel.text = question.avatarQuestionName
    }
}
