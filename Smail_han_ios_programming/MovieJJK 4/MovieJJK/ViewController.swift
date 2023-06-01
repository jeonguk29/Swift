//
//  ViewController.swift
//  MovieJJK
//
//  Created by comsoft on 2023/05/04.
//

import UIKit

let name = ["1. 가디언즈 오브 갤럭시: Volume 3", "2. 슈퍼 마리오 브라더스", "3. 드림","4. 존 윅 4", "5. 스즈메의 문단속", "6. 옥수역귀신", "7. 리바운드", "8. 더 퍼스트 슬램덩크", "9. 킬링 로맨스", "10. 치치핑핑의 쿵쿵따 탐험대",]


// 구조체라 모두 프로토콜을 채택한 것임
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    
    let movieNm: String
    let audiAcc: String // 누적관객수를 출력합니다.
    let audiCnt: String // 해당일의 관객수를 출력합니다.
    let salesShare: String // 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율을 출력합니다.
    let salesAcc: String // 누적매출액을 출력합니다.
    
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // 셀에 네트워크 작업이후 디코드한 데이터를 찍기위해 생성
    var movieData : MovieData?
    
    // 날짜 자동 지정하기위해 var로 변환
    var movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=4d5d8aaff18ee7542b218db4a2632b6b&targetDt="
    // http에 s붙여주기
    
    @IBOutlet weak var table: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        movieURL += makeYesterdayString() // getData호출전 URL의 어제 날짜 문자 추가
        getData()
    }
    
    func makeYesterdayString() -> String {
            let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let dateF = DateFormatter()
            dateF.dateFormat = "yyyyMMdd"
            let day = dateF.string(from: y)
            return day
     }
    
//    func getYesterdayDate() -> String {
//        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) // 어제 날짜 계산 -2면 그제 날짜
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyyMMdd" // 날짜 형식 지정
//
//        if let yesterdayDate = yesterday {
//            let formattedDate = dateFormatter.string(from: yesterdayDate)
//            return formattedDate
//        } else {
//            return "" // 어제 날짜를 가져올 수 없는 경우 빈 문자열 반환
//        }
//    }
    
    
    func getData(){
        if let url = URL(string: movieURL){
            //1. URL(구조체) 객체 생성
            // 실패 가능 생성자라 옵셔널 타입으로 반환되기 때문에 한번 풀어서 사용
            
            let session = URLSession(configuration: .default) // 2. URLSession 객체 만들기
            //  3. URLSession 인스턴스에게 task주기
            let tesk = session.dataTask(with: url) { data, response, error in
                // 에러가 있는지 체크 nil이면 에러가 없다는 것 아닐때 에러가 있음
                if error != nil {
                    print(error!)
                    return
                }
                
                if let JSONdata = data{
                    //print(JSONdata, response!)
                    
                    // utf8 인코딩 방식으로 바꿔서 출력
                    let dataString = String(data: JSONdata, encoding: .utf8)
                    // print(dataString!)
                    
                    let docoder = JSONDecoder()
                    // throws 키워드 있는 메서드는 예외처리를 해줘야함
                    do {
                        let decodedData = try docoder.decode(MovieData.self, from: JSONdata)
                        
                        // 클로저안에서 클래스에 저장속성 사용시 self키워드 필요
                        self.movieData = decodedData
                        
                        // UI 처리 메인 스레드에서 처리
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                        
                        print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                        print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].salesAcc)
                    }catch{
                        print(error)
                    }
                    
                }
            }
            tesk.resume() // task시작하기 task.resume()
        }
        
    }
    
    // 뷰 컨트롤러에게 segue가 수행될 예정임을 알림
    // segue 실행되기 직전에 자동으로호출되는 메서드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! DetailViewController
        //segue.destination는 UIViewController 타입임 다운 캐스팅해서 사용하기
        let myIndexPath = table.indexPathForSelectedRow!
        let row = myIndexPath.row
        dest.movieName = (movieData?.boxOfficeResult.dailyBoxOfficeList[row].movieNm)!
        // segue.destination 는 UIViewController 형임
        // 보내면 viewDidLoad에서 이름을 바꾸기 때문에 뷰에 올라올때마다 이름이 바뀔수 있는 것임
   
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        //cell.movieName.text = name[indexPath.row]
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        //cell.audiAccumulate.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc
        if let aCnt = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc {
                   let numF = NumberFormatter()
                   numF.numberStyle = .decimal
                   let aCount = Int(aCnt)!
                   let result = numF.string(for: aCount)!+"명"
                   cell.audiAccumulate.text = "누적 관객수:\(result)"
                   //cell.audiCount.text = "어제:\(aCnt)명"
               }
        //cell.audiCount.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt
        if let aCnt = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt {
                   let numF = NumberFormatter()
                   numF.numberStyle = .decimal
                   let aCount = Int(aCnt)!
                   let result = numF.string(for: aCount)!+"명"
                   cell.audiCount.text = "어제 관객수:\(result)"
                   //cell.audiCount.text = "어제:\(aCnt)명"
               }
        //cell.salesAcc.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].salesAcc
        if let aCnt = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].salesAcc {
                   let numF = NumberFormatter()
                   numF.numberStyle = .decimal
                   let aCount = Int(aCnt)!
                   let result = numF.string(for: aCount)!+"원"
                   cell.salesAcc.text = "누적 매출액:\(result)"
                   //cell.audiCount.text = "어제:\(aCnt)명"
               }
        
        cell.salesShare.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].salesShare
        
       
        return cell
    }
    
    // 테이블 헤더 주기 텍스트를 할때는 이 메서드를 사용하면 되지만 그래픽 같은것을 이용시 viewForHeaderInSection 메서드 이용
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "박스오피스(영화진흥위원회제공:"+makeYesterdayString()+")"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Woogie"
    }
    
    
}


