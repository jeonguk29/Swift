//
//  ToDoCell.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit

/*
 💁
 셀을 눌렀을때 다음 화면이 아니라 올라와 있는 버튼 누르면 다음 화면가게 구현을 해야함
 이것을 델리게이트 패턴으로 구현해줌
 */

protocol UpdateButtonProtocol: AnyObject {
    func updateButtonTapped(cell: ToDoCell)
}

final class ToDoCell: UITableViewCell {

    @IBOutlet weak var backgoundView: UIView!
    
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    //💁
    //weak var delegate: UpdateButtonProtocol? //해당 프로토콜을 채택한 타입한테 시키는 것임
    
    // ToDoData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
    var toDoData: ToDoData? { // 옵셔널 타입으로 ToDoData을 담을 수 있게 만듬
        didSet {
            configureUIwithData() // 속성 감시자를 통해 데이터 들어오면 셋팅
        }
    }
    
    
    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀(자신)을 전달)
    // - 변수에 타입이 함수고 클로저를 담아둠
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }
    
    // 스토리보드의 생성자
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // 기본 UI
    func configureUI() {
        backgoundView.clipsToBounds = true
        backgoundView.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 10
    }
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        toDoTextLabel.text = toDoData?.memoText
        dateTextLabel.text = toDoData?.dateString
        guard let colorNum = toDoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        updateButton.backgroundColor = color.buttonColor
        backgoundView.backgroundColor = color.backgoundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // 버튼을 누르면 해당 부분 실행

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        // 뷰컨트롤로에서 전달받은 클로저를 실행 (내 자신 ToDoCell을 전달하면서) ⭐️
        updateButtonPressed(self)
        
        
        
        //delegate?.updateButtonTapped(cell: self)
        //💁 커스텀 델리게이트로 버튼 눌릴때 동작전달한다면
        // 이렇게 전달하고 뷰컨에서 채택해서 사용하면 됨
    }
}
