//
//  QuestionCell.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/05.
//

import UIKit

class QuestionCell: UITableViewCell {


    @IBOutlet weak var questionNameLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
