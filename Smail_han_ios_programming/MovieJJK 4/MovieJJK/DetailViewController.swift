//
//  DetailViewController.swift
//  MovieJJK
//
//  Created by comsoft on 2023/05/25.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var movieName = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // nameLabel.text = movieName
        navigationItem.title = movieName
        
        /* 크룸 url
        
        guard let url = URL(string: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EB%B0%95%EC%8A%A4%EC%98%A4%ED%94%BC%EC%8A%A4") else {return}
        
         사파리 url search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=박스오피스&oquery=영화순위&tqi=ibJS3sprvhGssFKpOfKssssstAw-448005
         url 사용시 주의점 url에 한글이 있어서 동작하지 않음 변환시켜주는 코드 필요
         */
        
        let urlKorString = "https://www.youtube.com/results?search_query="+movieName
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string:urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
