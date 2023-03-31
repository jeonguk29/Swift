//
//  DetailViewController.swift
//  TableView
//
//  Created by 정정욱 on 2023/03/31.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieData: Movie? // 디테일 부분은 전 화면에서 데이터를 받아 그대로 뿌려주면 되는 것임
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI(){
        mainImageView.image = movieData?.movieImage
        movieNameLabel.text = movieData?.movieName
        descriptionLabel.text = movieData?.movieDescription
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
