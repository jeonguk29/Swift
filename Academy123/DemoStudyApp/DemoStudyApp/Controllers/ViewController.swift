//
//  ViewController.swift
//  MemoStudyApp
//
//  Created by 정정욱 on 2023/04/05.
//

import UIKit

class ViewController: UIViewController{

    
    // 질문리스트 파이어베이스에 등록하는것도 괜찮은거 같음
    //var questionArray: [Question] = []
    
    var questionDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        questionDataManager.makeQuestionData() // 파이어베이스 연동해서 뽑아오는 코드로 변경
//        questionArray = questionDataManager.getMovieData() // 질문, 답 데이터 전달 받음
        
        
    }


    
}


extension ViewController: UITableViewDataSource{
    
    // 컨텐츠를 몇개를 표시할까? : 이론 Part는 파이어베이스에 우리가 저장하는 방식으로 구현
    // 구현 Part는 스토리 보드 or 코드로 구현하여 업데이트하는 방식
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionDataManager.getQuestionData().count // 즉시 질문배열 리턴값을 카운트
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        
        let question = questionDataManager.getQuestionData()[indexPath.row] // 즉시 질문배열을 담음
        
        cell.questionNameLabel.text = question.questionName
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    
    // 셀 선택시 세그웨이로 연결되어 있는 toDetail을 찾고 해당 셀 데이터를 전송
    // performSegue실행 후 prepare 자동 실행 그때 indexPath 값을 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! AnswerDetailViewController
            
            // 우리가 전달하기 원하는 질문-답 데이터
            
            let array = questionDataManager.getQuestionData()
            let indexPath = sender as! IndexPath
            
            detailVC.questionData = array[indexPath.row]
      
        }
           
    }
    
    
}
