//
//  SecondVCViewController.swift
//  DemoStudyApp
//
//  Created by 정정욱 on 2023/04/09.
//

import UIKit

class SecondVCViewController: UIViewController {

    
    @IBOutlet weak var mainLabelName: UILabel!
    
    // 스토리보드 뷰와 연결된 후 (한번만 호출): 코드와 스토리보드의 뷰가 연결된 후
    override func viewDidLoad() {
        super.viewDidLoad()
        print("====VC-2 viewDidLoad 호출됨")
        mainLabelName.text =
                  """
                        VC-1 viewDidLoad 호출됨
                        VC-1 viewWillAppear 호출됨
                        VC-1 viewDidAppear 호출됨
                        ====VC-2 viewDidLoad 호출됨
                  """
    }

    // 뷰가 나타나기 전
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("====VC-2 viewWillAppear 호출됨")
        sleep(1)
        mainLabelName.text =
                  """
                        VC-1 viewDidLoad 호출됨
                        VC-1 viewWillAppear 호출됨
                        VC-1 viewDidAppear 호출됨
                        ====VC-2 viewDidLoad 호출됨
                        VC-1 viewWillDisappear 호출됨
                  """
    }
    
    // 뷰가 나타난 후
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("====VC-2 viewDidAppear 호출됨")
        sleep(2)
        mainLabelName.text =
                  """
                          VC-1 viewDidLoad 호출됨
                          VC-1 viewWillAppear 호출됨
                          VC-1 viewDidAppear 호출됨
                          ====VC-2 viewDidLoad 호출됨
                          VC-1 viewWillDisappear 호출됨
                          ====VC-2 viewWillAppear 호출됨
                          VC-1 viewDidDisappear 호출됨
                          ====VC-2 viewDidAppear 호출됨
                  """
    }
    
    // 뷰가 사라지기 전
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("====VC-2 viewWillDisappear 호출됨")
    }
    
    // 뷰가 사라지기 전
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("====VC-2 viewDidDisappear 호출됨")
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print("====VC-2 메모리에서 내려감")
    }

}
