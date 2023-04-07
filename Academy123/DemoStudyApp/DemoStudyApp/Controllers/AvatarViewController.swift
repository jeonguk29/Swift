//
//  AvatarViewController.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/07.
//

import UIKit

class AvatarViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var avatarDataManager = AvatarDataManager()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarDataManager.makeQuestionData()
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
  

}


extension AvatarViewController: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarDataManager.getQuestionData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Part2CollectionViewCell", for: indexPath) as! Part2CollectionViewCell
        
       let question = avatarDataManager.getQuestionData()[indexPath.row] // 즉시 질문배열을 담음
        
        cell.avaterQuestionLabel.text = question.avatarQuestionName
        cell.avaterQuestionImage.image = question.avatarQuestionImage
        
        return cell
    }
}

// 각 셀의 레이아웃 정해줘야함
extension ViewController: UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    

}

//extension ViewController: UICollectionViewDelegate{
//
//}
