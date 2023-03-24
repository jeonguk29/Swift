//
//  DiceManager.swift
//  DiceGame
//
//  Created by Allen H on 2021/12/26.
//

import UIKit

struct DiceManager {
    private var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    func getRandomDice() -> UIImage {
        return diceArray.randomElement()!
        // 다른데서 호출시 랜덤 이미지를 하나 얻어갈것임
    }
    
    func getFirstDice() -> UIImage {
        return diceArray[0]
        // 첫번째 아이템을 반환
    }
}
